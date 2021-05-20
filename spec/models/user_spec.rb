require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:first_name) }
    end
    context 'length' do
      it { is_expected.to validate_length_of(:first_name).is_at_most(30) }
    end
  end
end
