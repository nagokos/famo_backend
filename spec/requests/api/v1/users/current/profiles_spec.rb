require 'rails_helper'

RSpec.describe "Api::V1::Users::Current::Profiles", type: :request do
  let!(:header) { { 'X-Requested-With': 'XMLHttpRequest' } }
  describe "POST /api/v1/users/current/profile" do
    context '正常系' do
      let!(:user) { create(:user, :high_school) }
      before do
        login_as(user)
        post '/api/v1/users/current/profile', headers: header, params: {
          profile: { group_id: Group.first.id, team_id: Team.first.id, official_number: 10 }
        }
      end
      it '２０１を返す' do
        expect(response.status).to eq(201)
      end

      it 'プロフィールを返す' do
        expect(json.length).to eq(1)
      end
    end

    context '誕生日を登録していない' do
      let!(:user) { create(:user) }
      before {
        login_as(user)
        post '/api/v1/users/current/profile', headers: header, params: {
          profile: { group_id: Group.first.id, team_id: Team.first.id, official_number: 10 }
        }
      }

      it '４００を返す' do
        expect(response.status).to eq(400)
      end

      it 'エラーメッセージを返す' do
        expect(json['message']).to eq('生年月日を登録してください')
      end
    end

    context '高校生ではない' do
      let!(:user) { create(:user, birth_date: Time.current) }
      before {
        login_as(user)
        post '/api/v1/users/current/profile', headers: header, params: {
          profile: { group_id: Group.first.id, team_id: Team.first.id, official_number: 10 }
        }
      }

      it '４００を返す' do
        expect(response.status).to eq(400)
      end

      it 'エラーメッセージを返す' do
        expect(json['message']).to eq('高校生のみ登録可能です')
      end
    end
  end

  describe 'PATCH /api/v1/users/current/profile' do
    context '正常系' do
      let!(:user) { create(:user, :player_student) }
      before do
        login_as(user)
        patch '/api/v1/users/current/profile', headers: header, params: {
          profile: { group_id: Group.first.id, team_id: Team.first.id, official_number: 10 }
        }
      end
      it '２００を返す' do
        expect(response.status).to eq(200)
      end

      it 'プロフィールを返す' do
        expect(json.length).to eq(1)
      end
    end
  end

  describe 'DELETE /api/v1/users/current/profile' do
    let!(:user) { create(:user, :player_student) }
    before do
      login_as(user)
      delete '/api/v1/users/current/profile', headers: header
    end

    it '２０４を返す' do
      expect(response.status).to eq(204)
    end
  end
end
