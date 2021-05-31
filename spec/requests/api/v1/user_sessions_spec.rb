require 'rails_helper'

RSpec.describe "Api::V1::UserSessions", type: :request do
  describe "POST /api/v1/login" do
    let(:user) { create(:user) }
    before { @header = { 'X-Requested-With': 'XMLHttpRequest' } }

    context '正常系' do
      before { user.activate! }
      before { post '/api/v1/login', headers: @header, params: { email: user.email, password: 'Foobar0123' } }

      it '成功して２００を返す' do
        expect(response.status).to eq(200)
      end

      it 'Cookieにセットする' do
        expect(response.headers['Set-Cookie'].split(';').first.split('token=').second).to_not be_empty
      end

      it 'ログインする' do
        expect(logged_in?).to be_truthy
      end
    end

    context '異常系' do
      context 'メールアドレスが間違っている' do
        before { post '/api/v1/login', headers: @header, params: { email: 'rails@example.com', password: 'Foobar0123' } }

        it '４００を返す' do
          expect(response.status).to eq(400)
        end

        it 'エラーメッセージを返す' do
          expect(json['email']).to eq('メールアドレスが間違っています')
        end
      end

      context 'ユーザーが有効ではない' do
        before { post '/api/v1/login', headers: @header, params: { email: user.email, password: 'Foobar0123' } }

        it '４００を返す' do
          expect(response.status).to eq(400)
        end

        it 'jsonを返す' do
          expect(json['key']).to eq('inactive')
        end
      end

      context 'パスワードが間違っている' do
        before do
          user.activate!
          post '/api/v1/login', headers: @header, params: { email: user.email, password: 'invalid0000' }
        end

        it '４００を返す' do
          expect(response.status).to eq(400)
        end

        it 'エラーメッセージを返す' do
          expect(json['password']).to eq('パスワードが間違っています')
        end
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
