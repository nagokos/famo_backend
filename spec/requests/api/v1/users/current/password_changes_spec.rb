require 'rails_helper'

RSpec.describe "Api::V1::Users::Current::PasswordChanges", type: :request do
  let!(:user) { create(:user) }
  let!(:header) { { 'X-Requested-With': 'XMLHttpRequest' } }
  before { login_as(user) }

  describe "PATCH /api/v1/users/current/password_change" do
    context '正常系' do
      before {
        patch '/api/v1/users/current/password_change', headers: header, params: {
          current_password: 'Foobar0123', user: { password: 'rails1111', password_confirmation: 'rails1111' }
        }
      }
      it '２００を返す' do
        expect(response.status).to eq(200)
      end
    end

    context '現在のパスワードが間違っている' do
      before {
        patch '/api/v1/users/current/password_change', headers: header, params: {
          current_password: 'Foobar1111', user: { password: 'rails1111', password_confirmation: 'rails1111' }
        }
      }
      it '４００を返す' do
        expect(response.status).to eq(400)
      end

      it 'エラーメッセージを返す' do
        expect(json['errors']['current_password']).to eq('有効なパスワードを入力してください')
        expect(json['message']).to eq('フォームに不備があります')
      end
    end

    context 'パスワードの変更に失敗する' do
      before {
        patch '/api/v1/users/current/password_change', headers: header, params: {
          current_password: 'Foobar0123', user: { password: 'rails1111', password_confirmation: 'rails1110' }
        }
      }
      it '４２２を返す' do
        expect(response.status).to eq(422)
      end

      it 'エラーメッセージを返す' do
        expect(json['errors']['password_confirmation'].first).to include('パスワードの入力が一致しません')
        expect(json['message']).to eq('フォームに不備があります')
      end
    end
  end
end
