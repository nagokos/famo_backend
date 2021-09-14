require 'rails_helper'

RSpec.describe 'Api::V1::Players', type: :request do
  describe 'GET /api/v1/players' do
    context 'position=GK' do
      before { get "/api/v1/players", params: { q: { position: 'GK' } } }
      it 'ポジションがGKのユーザーを返す' do
        expect(json['users'].pluck('profile').pluck('position')).to_not include('DF')
      end
    end

    context 'team=1' do
      before { get "/api/v1/players", params: { q: { team_id: 1 } } }
      it '所属チームが青森山田高校のユーザを返す' do
        expect(json['users'].pluck('profile').pluck('team')).to_not include('ブランデュー弘前U-18')
      end
    end

    context 'page=2' do
      let!(:user) { User.first }
      before { get "/api/v1/players", params: { page: 2 } }
      it '二ページ目のユーザーを返す' do
        expect(json['users'].pluck('id')).to_not include(user.id)
      end
    end

    context 'rating=trueの場合' do
      let!(:user) { User.joins(:profile).order(rate: :desc).first }
      before { get "/api/v1/players", params: { q: { rating: true } } }
      it 'レートを基準に降順に並び替える' do
        expect(json['users'].first['id']).to eq(user.id)
      end
    end
  end
end
