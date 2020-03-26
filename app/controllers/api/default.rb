# frozen_string_literal: true

# require 'api/exception/common'

module API
  module Default
    extend ActiveSupport::Concern

    included do
      include Helpers::CommonHelpers

      version 'v1', using: :path

      content_type :json, 'application/json'
      content_type :txt, 'text/plain'

      default_format :json

      rescue_from API::Exception::Common::AuthUser do |_e|
        error!({ code: 1001, error: 'unauthorized' }, 401)
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        error!({ code: 1002, error: e.message }, 400)
      end

      rescue_from NoMethodError do |e|
        error!({ code: 1003, error: e.message }, 422)
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        error!({ code: 1004, error: e.message }, 404)
      end

      rescue_from :all do |e|
        error!({ code: 1000, error: e.message }, 500)
      end
    end
  end
end
