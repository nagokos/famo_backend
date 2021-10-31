require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  describe 'associations' do
    it 'has_many :teams :restrict_with_exception' do
      is_expected.to have_many(:teams).dependent(:restrict_with_exception)
    end
  end

  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
