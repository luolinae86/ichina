# frozen_string_literal: true

module API
  module Entities
    class Topic < Grape::Entity
      expose :id, :content, :latitude, :longitude, :status, :topic_type, :viewed_count, :uuid, :created_at, :is_urgent
      expose :customer, using: API::Entities::Customer
      expose :complaints, using: API::Entities::Complaint
    end
  end
end
