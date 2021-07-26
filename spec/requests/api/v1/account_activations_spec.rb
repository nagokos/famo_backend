require 'rails_helper'

RSpec.describe 'Api::V1::AccountActivations', type: :request do
  before { @header = { 'X-Requested-With': 'XMLHttpRequest' } }
  describe 'POST /api/v1/account_activations' do
    let!(:user) { create(:user) }
    context 'パラメーターと一致するユーザーがいる場合' do
      before { post '/api/v1/account_activations', headers: @header, params: { email: user.email } }

      it '成功して２００を返す' do
        expect(response.status).to eq(200)
      end

      it '認証メールが送信されていること' do
        expect(ActionMailer::Base.deliveries.size).to eq(2) #ユーザーが作成されるタイミングで一通送られるので2
      end
    end

    context 'パラメータと一致するユーザーが見つからない場合' do
      before  { post '/api/v1/account_activations', headers: @header, params: { email: 'rails@example.com' } }

      it '失敗して４００を返す' do
        expect(response.status).to eq(400)
      end

      it 'エラーメッセージを返す' do
        expect(json['errors']['email']).to eq('ユーザーが見つかりませんでした')
      end
    end

    context '既に認証済みの場合' do
      before do
        user.activate!
        post '/api/v1/account_activations', headers: @header, params: { email: user.email }
      end

      it '失敗して４００を返す' do
        expect(response.status).to eq(400)
      end

      it 'エラーメッセージを返す' do
        expect(json['errors']['email']).to eq('アカウントは認証済みです')
      end
    end
  end

  describe 'GET /api/v1/account_activation/:id(token)/edit' do
    context '認証URLが正常である場合' do
      let!(:user) { create(:user) }
      before { get "/api/v1/account_activations/#{user.activation_token}/edit", headers: @header }

      it '成功してリダイレクトする' do
        expect(response.status).to eq(302)
      end

      it 'Cookieにセットする' do
        expect(response.headers['Set-Cookie'].split(';').first.split('token=').second).to_not be_empty
      end

      it 'ログインする' do
        expect(logged_in?).to be_truthy
      end
    end

    context '認証URLの有効期限が切れている場合' do #token_expired
      let!(:user) { create(:user) }
      before do
        travel_to(1.day.since)
        get "/api/v1/account_activations/#{user.activation_token}/edit", headers: @header
      end

      it '失敗して４００を返す' do
        expect(response.status).to eq(400)
      end

      it 'エラーメッセージを返す' do
        expect(json['message']).to eq('認証メールの取得からやり直してください')
      end
    end

    context '認証URLが使用済みである場合' do #user_not_found
      let!(:user) { create(:user) }
      before { get "/api/v1/account_activations/#{user.activation_token}/edit", headers: @header }

      it '失敗して４００を返す' do
        get "/api/v1/account_activations/#{user.activation_token}/edit", headers: @header
        expect(response.status).to eq(400)
      end

      it 'エラーメッセージを返す' do
        get "/api/v1/account_activations/#{user.activation_token}/edit", headers: @header
        expect(json['message']).to eq('認証済み又はURLが無効です')
      end
    end
  end
end
