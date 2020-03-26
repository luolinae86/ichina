# frozen_string_literal: true

module API
  module Entities
    class Topic < Grape::Entity
      expose :content, :latitude, :longitude, :status, :topic_type, :viewed_count, :uuid, :created_at
      expose :customer, using: API::Entities::Customer
    end
  end
end
