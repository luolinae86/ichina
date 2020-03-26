# frozen_string_literal: true

require 'json'
module API
  module V1
    class Common < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      before do
        auth_user
      end

      desc '配置接口'
      params do
        requires :uuid, type: String, desc: 'uuid is needed'
      end
      get '/common/config' do
        # 当前用户的权限 考虑做缓存
        config = Rails.cache.fetch(current_user.phone + '_config', expires_in: 1.seconds) do
          config = {}
          config[:account_ability] = {
            has_rider_group: current_user.rider_group_member.blank? ? false : true,
            is_group_manager: current_user.rider_group.blank? ? false : true
          }
        end
        present response: success_response, config: config
      end
    end
  end
end
