require 'rails_helper'

RSpec.describe "Api::V1::Base", type: :request do
  describe '#check_xhr_header' do
    context 'リクエストヘッダーにXMLHttpRequestがない場合' do
      it '失敗して４０３を返す' do
        post '/api/v1/users', params: { user: FactoryBot.attributes_for(:user) }
        expect(response.status).to eq(403)
      end
    end
  end
end