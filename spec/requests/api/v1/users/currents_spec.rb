require 'rails_helper'

RSpec.describe "Api::V1::Users::Currents", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/users/currents/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/users/currents/update"
      expect(response).to have_http_status(:success)
    end
  end

end
