require 'rails_helper'

RSpec.describe League, type: :model do
  describe 'association' do
    it 'has_many :categories :restrict_with_exception' do
      is_expected.to have_many(:categories).dependent(:restrict_with_exception)
    end
  end
end
