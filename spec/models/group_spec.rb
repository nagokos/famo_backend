require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'associations' do
    it 'belongs_to :category' do
      is_expected.to belong_to(:category)
    end
  end
end
