require 'rails_helper'

RSpec.describe Authentication, type: :model do
  describe 'associations' do
    context 'belongs_to' do
      it { is_expected.to belong_to(:user) }
    end
  end

  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:uid) }
      it { is_expected.to validate_presence_of(:provider) }
    end
  end
end
