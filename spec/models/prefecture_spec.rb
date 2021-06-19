require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  describe 'association' do
    it 'has_many :teams :restrict_with_exception' do
      is_expected.to have_many(:teams).dependent(:restrict_with_exception)
    end
  end
end
