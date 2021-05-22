require 'rails_helper'

RSpec.describe "Api::V1::Users::Currents", type: :request do
  describe "GET /api/v1/users/current" do
    let(:user) { create(:user) }
    context 'ログインしている場合' do
      before do
        login_as(user)
        get '/api/v1/users/current'
      end

      it "２００を返す" do
        expect(response.status).to eq(200)
      end

      it 'ログインユーザーを返す' do
        expect(json['id']).to eq(current_user.id)
      end
    end

    context 'ログインしていない場合' do
      it '４０１を返す' do
        get '/api/v1/users/current'
        expect(response.status).to eq(401)
      end
    end
  end

  # describe "GET /update" do
  #   it "returns http success" do
  #     get "/api/v1/users/currents/update"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
