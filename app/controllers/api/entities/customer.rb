# frozen_string_literal: true

module API
  module Entities
    class Customer < Grape::Entity
      expose :name, :phone
    end
  end
end
