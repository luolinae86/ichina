# frozen_string_literal: true

module API
  module Exception
    module Common
      class Error < Grape::Exceptions::Base
        attr :code, :text

        def initialize(opts = {})
          @code    = opts[:code]   || 1000
          @text    = opts[:text]   || ''
          @status  = opts[:status] || 400
          @message = @text
        end
      end

      class AuthUser < Error
        def initialize
          super code: 1000, text: 'Authorization failed', status: 401
        end
      end
    end
  end
end
