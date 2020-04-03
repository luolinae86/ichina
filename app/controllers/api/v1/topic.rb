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

        params :uuid_topic_uuid do
          requires :uuid, type: String, desc: '请传入用户 uuid'
          requires :topic_uuid, type: String, desc: '请传入topic uuid'
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
          uuid: SecureRandom.uuid.delete('-')
        )

        current_user.update_attributes(social_account: params[:social_account])

        present topic: (present topic, with: Entities::Topic),
                response: success_response
      end

      desc '更新帖子'
      params do
        use :uuid_latitude_longitude
        requires :topic_uuid, type: String, desc: '请传入topic uuid'
        requires :content, type: String, desc: '帖子内容'
        requires :is_urgent, type: Boolean, desc: '是否紧急'
      end
      post '/topic/update' do
        topic = ::Topic.with_uuid(params[:topic_uuid]).last
        topic.update_attributes(
          content: params[:content],
          is_urgent: params[:is_urgent],
          latitude: params[:latitude],
          longitude: params[:longitude]
        )
        present topic: (present topic, with: Entities::Topic),
                response: success_response
      end

      desc '完成帖子'
      params do
        use :uuid_topic_uuid
      end
      post '/topic/done' do
        topic = ::Topic.with_uuid(params[:topic_uuid]).last
        topic.update_attributes(status: :done)
        present topic: (present topic, with: Entities::Topic),
                response: success_response
      end

      desc '删除'
      params do
        requires :uuid, type: String, desc: '请传入uuid'
        requires :topic_uuid, type: String, desc: '请传入topic uuid'
      end
      post '/topic/delete' do
        topic = ::Topic.with_uuid(params[:topic_uuid]).last
        return { response: error_response(ERROR_CODE[:POP_UP], '完成的记录不能删除') } if topic.status == 'done'

        topic.destroy

        present response: success_response
      end

      desc '查询一定距离内的话题列表'
      params do
        use :uuid_latitude_longitude
        requires :distance, type: String, desc: '距离'
      end
      get '/topic/within_distance' do
        origin = Geokit::LatLng.new(params[:latitude], params[:longitude])
        topics = ::Topic.includes(:customer, :complaints)\
                        .within(params[:distance], origin: origin).with_status(:published)
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
        topics = ::Topic.includes(:customer, :complaints)\
                        .with_customer_id(current_user.id).with_topic_type(params[:topic_type])
        present topics: (present topics, with: Entities::Topic),
                response: success_response
      end

      desc '话题被投诉'
      params do
        requires :uuid, type: String, desc: '请传入用户 uuid'
        requires :topic_id, type: Integer, desc: '请传入topic id'
        requires :content
        requires :complaint_type, \
                 type: String, \
                 values: %w[illegal_and_prohibited pornography attack advertisement bad_information], \
                 desc: '投诉类型'
      end
      post 'topic/complaint' do
        complaint = Complaint.create(
          topic_id: params[:topic_id],
          complaint_type: params[:complaint_type],
          content: params[:content]
        )

        present complaint: (present complaint, with: Entities::Complaint),
                response: success_response
      end

    end
  end
end
