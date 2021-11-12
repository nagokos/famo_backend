require 'rails_helper'

# class Profile < ApplicationRecord
#   belongs_to :group
#   belongs_to :team
#   belongs_to :user

#   validates :position, presence: true
#   validates :official_number, presence: true, numericality: true
#   validates :practice_number, numericality: true, allow_blank: true
#   validates :career, length: { maximum: 50 }
#   validates :rate, presence: true

#   enum position: { GK: 0, DF: 1, MF: 2, FW: 3 }
# end

RSpec.describe Profile, type: :model do
  describe 'associations' do
    context 'belongs_to' do
      it { is_expected.to belong_to(:group) }
      it { is_expected.to belong_to(:team) }
      it { is_expected.to belong_to(:user) }
    end
  end

  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:position) }
      it { is_expected.to validate_presence_of(:official_number) }
      it { is_expected.to validate_presence_of(:rate) }
    end

    context 'numericality' do
      it { is_expected.to validate_numericality_of(:official_number) }
      it { is_expected.to validate_numericality_of(:practice_number) }
    end

    context 'length' do
      it { is_expected.to validate_length_of(:career).is_at_most(50) }
    end
  end

  describe 'default' do
    let(:user) { create(:user) }
    let(:profile) { create(:profile, user: user) }

    it 'positionがGKであること' do
      expect(profile.position).to eq('GK')
    end

    it 'rateが0であること' do
      expect(profile.rate).to eq(0)
    end
  end
end
