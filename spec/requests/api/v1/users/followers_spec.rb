require 'rails_helper'

RSpec.describe "Api::V1::Users::Followers", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  describe "GET /api/v1/users/:user_id/followers" do
    before { other_user.follow(user) }
    it 'フォロワーを返すこと' do
      get "/api/v1/users/#{user.id}/followers"
      expect(json['users'].pluck('id')).to include(other_user.id)
    end

    context 'page=2' do
      before do
        create_list(:user, 21) { |user2| user2.follow(user) }
        get "/api/v1/users/#{user.id}/followers", params: { page: 2 }
      end
      it '二ページ目のユーザーを返す' do
        expect(response.headers['Current-Page']).to eq('2')
      end
    end
  end
end
