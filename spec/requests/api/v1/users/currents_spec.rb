require 'rails_helper'

RSpec.describe 'Api::V1::Users::Currents', type: :request do
  let!(:user) { create(:user) }
  let!(:header) { { 'X-Requested-With': 'XMLHttpRequest' } }
  before { login_as(user) }

  describe 'GET /api/v1/users/current' do
    context 'ログインしている場合' do
     before { get '/api/v1/users/current' }

      it "２００を返す" do
        expect(response.status).to eq(200)
      end

      it 'ログインユーザーを返す' do
        expect(json['user']['id']).to eq(current_user.id)
      end
    end
  end

  describe 'PATCH /api/v1/users/current' do
    context '正常系' do
      before { patch '/api/v1/users/current', headers: header, params: { user: { name: '中山太郎' } } }
      it 'current_userを返す' do
        expect(json['user']['id']).to eq(user.id)
      end
    end

    context '異常系' do
      let!(:other_user) { create(:user) }
      before { patch "/api/v1/users/current", headers: header, params: { user: { email: other_user.email } } }
      it '４２２を返す' do
        expect(response.status).to eq(422)
      end

      it 'エラーメッセージを返す' do
        expect(json['errors']['email'].first).to eq('このメールアドレスは既に存在します')
        expect(json['message']).to eq('フォームに不備があります')
      end
    end
  end

  # describe 'POST /api/v1/users/current/presigned_post' do
  #   before { post '/api/v1/users/current/presigned_post', headers: header, params: { avatar: 'test.png' } }

  #   it '２００が返されること' do
  #     expect(response.status).to eq(200)
  #   end

  #   it '期限付きURLが返されること' do
  #     expect(json['avatar_url']).to be_truthy
  #   end
  # end

  describe 'DELETE /api/v1/users/current' do
    before { delete '/api/v1/users/current', headers: header }
    it 'ユーザーが削除されること' do
      expect(User.all).to_not include(user)
    end
  end
end
