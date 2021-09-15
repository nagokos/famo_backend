require 'rails_helper'

RSpec.describe "Api::V1::PasswordResets", type: :request do
  let!(:header) { { 'X-Requested-With': 'XMLHttpRequest' } }
  describe "POST /api/v1/password_resets" do
    let(:user) { create(:user) }
    context '正常系' do
      before { post '/api/v1/password_resets', headers: header, params: { email: user.email } }
      it 'リセットメールを一通送信する' do
        expect(ActionMailer::Base.deliveries.size).to eq(2) #ユーザーが作成されるタイミングで一通送られるので2
      end
    end

    context '異常系' do
      before { post '/api/v1/password_resets', headers: header, params: { email: 'rails@gmail.com' } }
      it 'エラーメッセージを返す' do
        expect(json['errors']['email']).to eq('ユーザーが見つかりませんでした')
        expect(json['message']).to eq('フォームに不備があります')
      end
    end
  end

  describe 'GET /api/v1/password_resets/:id/edit' do
    context '正常系' do
      let(:user) { create(:user) }
      before do
        user.deliver_reset_password_instructions!
        get "/api/v1/password_resets/#{user.reset_password_token}/edit"
      end

      it 'パスワード再設定ページへリダイレクト' do
        expect(response.status).to eq(302)
      end

      it 'cookieにトークンをセット' do
        expect(response.headers['Set-Cookie'].split(';').first.split('=').second).to eq(user.reset_password_token)
      end
    end

    context '無効なURL' do
      before { get "/api/v1/password_resets/jagkljklagjkal/edit" }

      it '失敗してリダイレクト' do
        expect(response.status).to eq(302)
      end

      it 'cookieにvalue=1をセット' do
        expect(response.headers['Set-Cookie'].split(';').first.split('=').second).to eq('1')
      end
    end

    context 'URLの有効期限が切れている' do
      let!(:user) { create(:user) }
      before do
        user.deliver_reset_password_instructions!
        travel_to(1.day.since)
        get "/api/v1/password_resets/#{user.reset_password_token}/edit"
      end

      it 'cookieにvalue=2をセット' do
        expect(response.headers['Set-Cookie'].split(';').first.split('=').second).to eq('2')
      end
    end
  end

  describe 'PATCH /api/v1/password_resets/:id' do
    let!(:user) { create(:user) }
    before do
      user.deliver_reset_password_instructions!
      patch "/api/v1/password_resets/#{user.reset_password_token}", headers: header, params: {
        user: { password: 'rails0000', password_confirmation: 'rails0000' }
      }
    end

    context '正常系' do
      it '成功して２００' do
        expect(response.status).to eq(200)
      end

      it 'Cookieを過去の日付にする(削除)' do
        expect(response.headers['Set-Cookie'].split(';').third.split(',').second < Time.current).to be_truthy
      end
    end
  end
end
