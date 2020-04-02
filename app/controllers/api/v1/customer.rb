# frozen_string_literal: true

require 'json'
require 'api/utils/wx_biz_data_crypt'

module API
  module V1
    class Customer < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'
      content_type :txt,  'text/plain'

      version 'v1', using: :path

      before do
      end

      desc '用户从小程序登陆注册'
      params do
        requires :code, type: String, desc: 'code is needed'
        optional :pc_id, type: String, desc: '从PC端带过来的id，主要作用是方便双方的认证'
      end
      post '/customer/register' do
        logger.info "Account:register params #{params}"
        code = params[:code]
        url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{Yetting.weixin['appid']}&secret=#{Yetting.weixin['secret']}&js_code=#{code}&grant_type=authorization_code"
        resp = HTTParty.get(url, timeout: 1)
        msg = JSON.parse(resp.body)
        logger.info "Account::register ====  message  #{msg}"

        return { response: error_response(ERROR_CODE[:POP_UP], '访问微信服务器错误') } unless msg['errcode'].blank?

        customer = ::Customer.find_or_create_by!(openid: msg['openid'])
        customer.update_attributes(pc_id: params[:pc_id]) unless params[:pc_id].blank?

        # 将session_key和uuid绑定，先放内存里面，后面可以获取
        redis = Redis.current
        redis.set(customer.uuid, msg['session_key'])

        present response: success_response,
                customer: (present customer, with: Entities::Customer)
      end

      desc '用户绑定手机号'
      params do
        optional :code, type: String, desc: '请传入code'
        requires :iv, type: String, desc: '请传入iv'
        requires :encrypted_data, type: String, desc: '请传入encrypted_data'
        requires :uuid, type: String, desc: '请传入uuid'
      end
      post '/customer/phone' do
        auth_user
        redis = Redis.current
        if params[:code].blank?
          session_key = redis.get(current_user.uuid)
        else
          url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{Yetting.weixin['appid']}&secret=#{Yetting.weixin['secret']}&js_code=#{params[:code]}&grant_type=authorization_code"
          resp = HTTParty.get(url, timeout: 1)
          if resp.code.to_s == '200'
            msg = JSON.parse(resp.body)
            logger.info "Account::phone ====  message  #{msg}"
            session_key = msg['session_key']
            redis.set(current_user.uuid, session_key)
          else
            logger.info "Account::phone r_phone resp #{resp}"
          end
        end

        pc = API::Utils::WxBizDataCrypt.new(Yetting.weixin['appid'], session_key)
        decrypted_message = pc.decrypt(params[:encrypted_data], params[:iv])
        logger.info "Account::phone decrypted_message #{decrypted_message}"

        current_user.update_attributes(phone: decrypted_message['phoneNumber'])
        present response: success_response,
                customer: (present current_user, with: Entities::Customer)
      end

      desc '用户更新昵称和头像'
      params do
        requires :uuid, type: String, desc: '请传入uuid'
        requires :nick_name, type: String, desc: '请传入nick_name'
        requires :head_url,  type: String, desc: '请传入head_url'
      end
      post '/customer/nick_name_head_url' do
        auth_user

        current_user.update_attributes(
          nick_name: params[:nick_name],
          head_url: params[:head_url]
        )

        present response: success_response,
                customer: (present current_user, with: Entities::Customer)
      end

    end
  end
end
