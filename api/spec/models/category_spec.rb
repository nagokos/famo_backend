require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'associations' do
    it 'belongs_to :league' do
      is_expected.to belong_to(:league)
    end

    it 'has_many :groups :restrict_with_exception' do
      is_expected.to have_many(:groups).dependent(:restrict_with_exception)
    end
  end

  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
