require 'rails_helper'

RSpec.describe "Api::V1::UserSessions", type: :request do
  describe "POST /api/v1/login" do
    let(:user) { create(:user) }
    before do
      user.activate!
      @header = { 'X-Requested-With': 'XMLHttpRequest' }
    end

    context 'パラメーターが妥当な場合' do
      before do
        post '/api/v1/login', headers: @header,
                               params: { email: user.email, password: 'Foobar0123' }
      end

      it '成功して２００を返す' do
        expect(response.status).to eq(200)
      end

      it 'Cookieにセットする' do
        token = create_token(user)
        expect(response.headers['Set-Cookie'].split(';').first.split('token=').second).to eq(token)
      end

      it 'ログインする' do
        expect(logged_in?).to be_truthy
      end
    end

    context 'パラメータが不正な場合' do
      before do
        post '/api/v1/login', headers: @header,
                               params: { email: 'rails@example.com', password: 'Foobar0123' }
      end

      it '失敗して４０１を返す' do
        expect(response.status).to eq(401)
      end

      it 'ログインできない' do
        expect(logged_in?).to be_falsey
      end
    end
  end

  # describe "GET /destroy" do
  #   it "returns http success" do
  #     get "/api/v1/user_sessions/destroy"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
