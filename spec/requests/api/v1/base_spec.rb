require 'rails_helper'

RSpec.describe "Api::V1::Base", type: :request do
  let!(:header) { { 'X-Requested-With': 'XMLHttpRequest' } }

  describe '#check_xhr_header' do
    context 'リクエストヘッダーにXMLHttpRequestがない場合' do
      before { post '/api/v1/users', params: { user: FactoryBot.attributes_for(:user) } }
      it '失敗して４０３を返す' do
        expect(response.status).to eq(403)
      end

      it 'エラーメッセージを返す' do
        expect(json['message']).to eq('アクセス権がありません')
      end
    end
  end

  describe '#check_activation' do
    let!(:user) { create(:user) }
    before { login_as(user) }
    context 'ユーザーがアクティブではない' do
      before do
        user.update(email: 'rails1234@gmail.com')
        patch '/api/v1/users/current', headers: header, params: { user: { name: 'aaa' } }
      end
      it '４０３を返す' do
        expect(response.status).to eq(403)
      end

      it 'エラーメッセージを返す' do
        expect(json['message']).to eq('アカウントを認証してください')
      end
    end
  end

  describe '#check_login' do
    context 'ログインしていない' do
      let!(:user) { create(:user) }
      let!(:other_user) { create(:user) }
      before { post "/api/v1/users/#{other_user.id}/relationships", headers: header }

      it '４０１を返す' do
        expect(response.status).to eq(401)
      end

      it 'エラーメッセージを返す' do
        expect(json['message']).to eq('ログインしてください')
      end
    end
  end
end