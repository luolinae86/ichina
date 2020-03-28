require 'grape_logging'

module  API
  module V1
    class Mount < Grape::API
      mount V1::Common
      mount V1::Customer
      mount V1::Topic
    end
  end
end