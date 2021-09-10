require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'associations' do
    it 'belongs_to :follower' do
      is_expected.to belong_to(:follower)
    end

    it 'belongs_to :followed' do
      is_expected.to belong_to(:followed)
    end
  end

  describe 'validations' do
    context 'uniqueness' do
      let!(:user) { create(:user) }
      let!(:user2) { create(:user) }
      let!(:relationship) { create(:relationship, follower: user, followed: user2) }

      it '同じユーザーをフォローできないこと' do
        relationship2 = build(:relationship, follower: user, followed: user2)
        expect(relationship2).to_not be_valid
      end
    end
  end
end
