require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'assocations' do
    it 'belongs_to :prefecture' do
      is_expected.to belong_to(:prefecture)
    end
  end

  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
