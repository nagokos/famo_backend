require 'rails_helper'

RSpec.describe 'Api::V1::Users::Followings', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe 'GET /api/v1/users/:user_id/following' do
    before { user.follow(other_user) }
    it 'フォローユーザーを返すこと' do
      get "/api/v1/users/#{user.id}/following"
      expect(json['users'].pluck('id')).to include(other_user.id)
    end

    context 'page=2' do
      before do
        create_list(:user, 21) { |user2| user.follow(user2) }
        get "/api/v1/users/#{user.id}/following", params: { page: 2 }
      end
      it '二ページ目のユーザーを返すこと' do
        expect(response.headers['Current-Page']).to eq('2')
      end
    end
  end
end
