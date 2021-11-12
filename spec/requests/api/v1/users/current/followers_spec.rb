require 'rails_helper'

RSpec.describe "Api::V1::Users::Current::Followers", type: :request do
  describe "GET /api/v1/users/current/followers" do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    before { login_as(user) }

    it 'フォロワーを返す' do
      user2.follow(user)
      get '/api/v1/users/current/followers'
      expect(json['users'].first['id']).to eq(user2.id)
    end

    context 'page=2' do
      before do
        create_list(:user, 21) { |other_user| other_user.follow(user) }
        get '/api/v1/users/current/followers', params: { page: 2 }
      end
      it '二ページ目のユーザーを返す' do
        expect(response.headers['Current-Page']).to eq('2')
      end
    end
  end
end
