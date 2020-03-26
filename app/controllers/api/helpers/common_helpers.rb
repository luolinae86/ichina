# frozen_string_literal: true

module API
  module Helpers
    module CommonHelpers
      extend ActiveSupport::Concern
      include API::Exception::Common

      included do
        helpers do
          def logger
            Rails.logger
          end

          def success_response
            {
              success: '1',
              description: 'success',
              errorcode: '0000',
              timestamp: Time.now.to_i
            }
          end

          def error_response(error_code, description)
            {
              success: '-1',
              description: description,
              errorcode: error_code.to_s,
              timestamp: Time.now.to_i
            }
          end

          def current_user
            @current_user ||= Customer.find_by_uuid(params[:uuid])
          end

          def auth_user
            raise AuthUser if current_user.nil?
          end
        end
      end

      ERROR_CODE = {
        POP_UP: 1001
      }.freeze
    end
  end
end
