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
        expect(response.headers['Set-Cookie'].split(';').first).to_not be_empty
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
          expect(json['errors']['email']).to eq('メールアドレスが間違っています')
        end
      end

      context 'ユーザーが有効ではない' do
        before { post '/api/v1/login', headers: @header, params: { email: user.email, password: 'Foobar0123' } }

        it '４００を返す' do
          expect(response.status).to eq(400)
        end

        it 'jsonを返す' do
          expect(json['errors']['key']).to eq('inactive')
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
          expect(json['errors']['password']).to eq('パスワードが間違っています')
        end
      end
    end
  end

  describe 'DELETE /api/v1/logout' do
    before { delete '/api/v1/logout', headers: @header }

    it 'cookiesのtokenが削除されること' do
      expect(response.headers['Set-Cookie']).to be_falsey
    end

    it 'current_userがnilになること' do
      expect(current_user).to eq(nil)
    end
  end
end
