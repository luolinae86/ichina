# frozen_string_literal: true

require 'json'
require 'api/utils/wx_biz_data_crypt'

module API
  module V1
    class Topic < Grape::API
      include Default

      format :json
      content_type :json, 'application/json'

      version 'v1', using: :path

      before do
        auth_user
      end

      helpers do
        params :uuid_latitude_longitude do
          requires :uuid, type: String, desc: '请传入uuid'
          requires :latitude, type: String, desc: 'latitude'
          requires :longitude, type: String, desc: 'longitude'
        end
      end

      desc '发布帖子'
      params do
        use :uuid_latitude_longitude
        requires :content, type: String, desc: '帖子内容'
        requires :topic_type, type: String, values: %w[need_help provide_help report_safe], desc: '帖子类型'
      end
      post '/topic/create' do
        topic = ::Topic.create(
          content: params[:content],
          topic_type: params[:topic_type],
          latitude: params[:latitude],
          longitude: params[:longitude],
          customer_id: current_user.id,
          uuid: SecureRandom.uuid.delete('-')
        )

        present topic: (present topic, with: Entities::Topic),
                response: success_response
      end

      desc '查询离我一定距离内的话题列表'
      params do
        use :uuid_latitude_longitude
        requires :distance, type: String, desc: '距离'
      end
      post '/topic/list' do

        origin = Geokit::LatLng.new(params[:latitude], params[:longitude])
        topics = ::Topic.within(params[:distance], origin: origin)
        present topics: (present topics, with: Entities::Topic),
                response: success_response
      end

      desc '查询我发表的话题列表'
      params do
        requires :uuid, type: String, desc: '请传入uuid'
        optional :topic_type, type: String, values: %w['' need_help provide_help report_safe], desc: '帖子类型'
      end
      post '/topic/list' do
        topics = ::Topic.with_customer_id(current_user.id).with_topic_type(params[:topic_type])

        present topics: (present topics, with: Entities::Topic),
                response: success_response
      end

    end
  end
end
