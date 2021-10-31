require 'rails_helper'

RSpec.describe "Api::V1::Relationships", type: :request do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:header) { { 'X-Requested-With': 'XMLHttpRequest' } }
  before do
    login_as(user)
    post "/api/v1/users/#{user2.id}/relationships", headers: header
  end

  describe 'GET /api/v1/users/:user_id/relationship/check' do
    context 'フォローしている場合' do
      it 'trueを返す' do
        get "/api/v1/users/#{user2.id}/relationships/check"
        expect(json['status']).to be_truthy
      end
    end

    context 'フォローしていない場合' do
      before { delete "/api/v1/users/#{user2.id}/relationships", headers: header }
      it 'falseを返す' do
        get "/api/v1/users/#{user2.id}/relationships/check"
        expect(json['status']).to be_falsey
      end
    end
  end

  describe 'DELETE /api/v1/users/:user_id/relationship' do
    before { delete "/api/v1/users/#{user2.id}/relationships", headers: header }
    context '正常系' do
      it '成功して２００を返す' do
        expect(response.status).to eq(200)
      end

      it 'フォローを解除する' do
        expect(user.following).to_not include(user2)
      end
    end
  end

  describe 'POST /api/v1/users/:user_id/relationship' do
    context '正常系' do
      it '成功して２０１を返す' do
        expect(response.status).to eq(201)
      end

      it 'ユーザーをフォローする' do
        expect(user.following).to include(user2)
      end
    end

    context '異常系' do
      before { post "/api/v1/users/#{user2.id}/relationships", headers: header }
      it '失敗して４００' do
        expect(response.status).to eq(400)
      end

      it 'エラーメッセージを返す' do
        expect(json['message']).to eq('すでにフォローしています')
      end
    end
  end
end
