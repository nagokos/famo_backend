require 'rails_helper'

RSpec.describe "Api::V1::Teams", type: :request do
  let!(:user) { create(:user) }
  let!(:header) { { 'X-Requested-With': 'XMLHttpRequest' } }
  before { login_as(user) }

  describe "POST /api/v1/teams" do
    context '正常系' do
      before { post '/api/v1/teams', headers: header, params: { team: { name: '川崎フロンターレU-18', prefecture_id: 1 } }  }

      it '２０１を返す' do
        expect(response.status).to eq(201)
      end

      it 'チームを作成する' do
        expect(Team.last.name).to eq('川崎フロンターレU-18')
      end
    end

    context '異常系' do
      before { post '/api/v1/teams', headers: header, params: { team: { name: '青森山田高校', prefecture_id: 1 } }  }

      it '４２２を返す' do
        expect(response.status).to eq(422)
      end

      it 'エラーメッセージを返す' do
        expect(json['errors']['name'].first).to eq('このチーム名は既に存在します')
        expect(json['message']).to eq('フォームに不備があります')
      end
    end
  end
end
