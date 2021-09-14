require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST /api/v1/users' do
    let!(:header) { { 'X-Requested-With': 'XMLHttpRequest' } }
    before do
      @valid_data = FactoryBot.attributes_for(:user)
      @invalid_data = FactoryBot.attributes_for(:user, :invalid)
    end

    context 'パラメータが妥当な場合' do
      it '成功して２０１を返す' do
        post '/api/v1/users', headers: header, params: { user: @valid_data }
        expect(response.status).to eq(201)
      end

      it 'ユーザーが登録される' do
        expect {
          post '/api/v1/users', headers: header, params: { user: @valid_data }
        }.to change(User, :count).by(1)
        expect(response.status).to eq(201)
      end

      it '認証メールが送信される' do
        post '/api/v1/users', headers: header, params: { user: @valid_data }
        expect(ActionMailer::Base.deliveries.size).to eq(1)
      end
    end

    context 'パラメータが不正な場合' do
      it '失敗して４２２を返す' do
        post '/api/v1/users', headers: header, params: { user: @invalid_data }
        expect(response.status).to eq(422)
      end

      it 'ユーザーが登録されない' do
        expect {
          post '/api/v1/users', headers: header, params: { user: @invalid_data }
        }.to change(User, :count).by(0)
        expect(response.status).to eq(422)
      end
    end

    context 'メールアドレスが重複した場合' do
      let!(:user) { create(:user) }
      it '失敗して４２２を返す' do
        post '/api/v1/users', headers: header, params: { user: { email: user.email } }
        expect(response.status).to eq(422)
      end

      it 'エラーメッセージを返す' do
        post '/api/v1/users', headers: header, params: { user: { email: user.email } }
        expect(response.status).to eq(422)
        expect(json['errors']['email']).to include('このメールアドレスは既に存在します')
      end
    end
  end
end
