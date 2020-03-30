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
        requires :is_urgent, type: Boolean, desc: '是否紧急'
        requires :content, type: String, desc: '帖子内容'
        requires :topic_type, type: String, values: %w[need_help provide_help report_safe], desc: '帖子类型'
        requires :social_account, type: String, desc: '社交帐号'
      end
      post '/topic/create' do
        topic = ::Topic.create(
          content: params[:content],
          topic_type: params[:topic_type],
          latitude: params[:latitude],
          longitude: params[:longitude],
          customer_id: current_user.id,
          is_urgent: params[:is_urgent],
          uuid: SecureRandom.uuid.delete('-'),
          social_account: params[:social_account]
        )

        current_user.update_attributes(social_account: params[:social_account]) if current_user.social_account.blank?

        present topic: (present topic, with: Entities::Topic),
                response: success_response
      end

      desc '完成帖子'
      params do
        requires :uuid, type: String, desc: '请传入用户 uuid'
        requires :topic_uuid, type: String, desc: '请传入topic uuid'
      end
      post '/topic/done' do
        topic = ::Topic.with_uuid(params[:topic_uuid]).last
        return { response: error_response(ERROR_CODE[:POP_UP], '没有记录') } if topic.blank?

        topic.update_attributes(status: :done)
        present topic: (present topic, with: Entities::Topic),
                response: success_response
      end

      desc '查询一定距离内的话题列表'
      params do
        use :uuid_latitude_longitude
        requires :distance, type: String, desc: '距离'
      end
      get '/topic/within_distance' do
        origin = Geokit::LatLng.new(params[:latitude], params[:longitude])
        topics = ::Topic.within(params[:distance], origin: origin)
        present topics: (present topics, with: Entities::Topic),
                response: success_response
      end

      desc '根据uuid查看单个记录详情'
      params do
        requires :uuid, type: String, desc: '请传入用户 uuid'
        requires :topic_uuid, type: String, desc: '请传入topic uuid'
      end
      get '/topic/by_uuid' do

        topic = ::Topic.with_uuid(params[:topic_uuid]).last
        return { response: error_response(ERROR_CODE[:POP_UP], '没有记录') } if topic.blank?

        # 更新这个记录的查看次数
        topic.update_attributes(viewed_count: topic.viewed_count + 1)
        present topic: (present topic, with: Entities::Topic),
                response: success_response
      end

      desc '查询我发表的话题列表'
      params do
        requires :uuid, type: String, desc: '请传入uuid'
        optional :topic_type, type: String, values: %w[need_help provide_help report_safe], desc: '帖子类型'
      end
      get '/topic/my_list' do
        topics = ::Topic.with_customer_id(current_user.id).with_topic_type(params[:topic_type])
        present topics: (present topics, with: Entities::Topic),
                response: success_response
      end


    end
  end
end
