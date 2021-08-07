require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'assocation' do
    it 'belongs_to :prefecture' do
      is_expected.to belong_to(:prefecture)
    end
  end

  describe 'presence' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
