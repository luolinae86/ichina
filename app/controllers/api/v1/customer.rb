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
        requires :account_type, type: String, desc: 'account is rider or merchant'
      end
      post '/customer/register' do
        logger.info "Account:register params #{params}"
        code = params[:code]
        url = "https://api.weixin.qq.com/sns/jscode2session?appid=#{Yetting.weixin['appid']}&secret=#{Yetting.weixin['secret']}&js_code=#{code}&grant_type=authorization_code"
        resp = HTTParty.get(url, timeout: 1)
        msg = JSON.parse(resp.body)
        logger.info "Account::register ====  message  #{msg}"

        return { response: error_response(ERROR_CODE[:POP_UP], '访问微信服务器错误') } unless msg['errcode'].blank?

        account = if params[:account_type] == 'rider'
                    Rider.find_or_create_by!(openid: msg['openid'])
                  else
                    Merchant.find_or_create_by!(openid: msg['openid'])
                  end

        # 将session_key和uuid绑定，先放内存里面，后面可以获取
        redis = Redis.current
        redis.set(account.uuid, msg['session_key'])

        has_rider_group = RiderGroupMember.find_by_rider_id(account.id).blank? ? false : true
        present response: success_response,
                account: {
                  uuid: account.uuid, id: account.id, phone: account.phone,
                  nick_name: account.nick_name, head_url: account.head_url,
                  has_rider_group: has_rider_group
                }
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
        has_rider_group = current_user.rider_group_member.blank? ? false : true
        present response: success_response,
                account: {
                  uuid: current_user.uuid, id: current_user.id, phone: current_user.phone,
                  nick_name: current_user.nick_name, head_url: current_user.head_url,
                  has_rider_group: has_rider_group
                }
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

        has_rider_group = current_user.rider_group_member.blank? ? false : true
        present response: success_response,
                account: {
                  uuid: current_user.uuid, id: current_user.id, phone: current_user.phone,
                  nick_name: current_user.nick_name, head_url: current_user.head_url,
                  has_rider_group: has_rider_group
                }
      end

      desc '用户完成了多少次帮助'
      params do
        requires :uuid, type: String, desc: '请传入uuid'
      end
      get '/customer/provide_help_numbers' do
        present response: success_response,
                count: ::Topic.with_customer_id(current_user.id).with_status(:done).count
      end

    end
  end
end
