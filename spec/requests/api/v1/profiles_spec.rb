require 'rails_helper'

RSpec.describe "Api::V1::Profiles", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/profiles/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/api/v1/profiles/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
