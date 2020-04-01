# frozen_string_literal: true

module API
  module Entities
    class Complaint < Grape::Entity
      expose :complaint_type, :content
    end
  end
end
