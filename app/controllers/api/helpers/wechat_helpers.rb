# frozen_string_literal: true

module API
  module Helpers
    module WechatHelpers
      extend ActiveSupport::Concern
      include API::Exception::Common

      included do
        helpers do

          def access_token
            redis = Redis.current
            access_token = redis.get('access_token')

            if access_token.blank?
              url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Yetting.weixin['appid']}&secret=#{Yetting.weixin['secret']}"
              resp = HTTParty.get(url, timeout: 1)
              msg = JSON.parse(resp.body)
              logger.info "access_token ====  message  #{msg}"
              access_token = msg['access_token']
              redis.set('access_token', access_token)
              redis.expire('access_token', 3600)
            end

            access_token
          end

          def security_message?(access_token, content)
            url = "https://api.weixin.qq.com/wxa/msg_sec_check?access_token=#{access_token}"
            data = {
              content: content
            }
            resp = HTTParty.post(url, body: data.to_json,
                                      headers: { 'Content-Type' => 'application/json' },
                                      timeout: 1)

            msg = JSON.parse(resp.body)
            logger.info "message_security_check ====  message  #{msg}"
            msg['errcode'] != 87_014
          end
        end
      end
    end
  end
end
