require 'rails_helper'

RSpec.describe "Riders", type: :request do
  describe "GET /riders" do
    it "works! (now write some real specs)" do
      get riders_path
      expect(response).to have_http_status(200)
    end
  end
end
