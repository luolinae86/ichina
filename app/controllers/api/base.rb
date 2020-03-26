# frozen_string_literal: true

require 'grape_logging'

module API
  class Base < Grape::API

    logger.formatter = GrapeLogging::Formatters::Default.new
    use GrapeLogging::Middleware::RequestLogger, logger: logger

    mount V1::Mount

    add_swagger_documentation(
      info: {
        title: 'Wai Mai API Documentation',
        contact_email: 'luolinae86@gmail.com'
      },
      mount_path: '/doc/swagger',
      doc_version: '0.1.0'
    )
  end
end
