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
        config = {}
        config[:system] = {
          tips: '近期英国疫情增长呈现下降走势'
        }
        present response: success_response, config: config
      end
    end
  end
end
