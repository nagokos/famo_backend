require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to validate_presence_of(:birth_date) }
      it { is_expected.to validate_presence_of(:avatar) }
      it { is_expected.to validate_presence_of(:role) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'length' do
      it { is_expected.to validate_length_of(:first_name).is_at_most(30) }
      it { is_expected.to validate_length_of(:last_name).is_at_most(30) }
      it { is_expected.to validate_length_of(:introduction).is_at_most(400) }
      it { is_expected.to validate_length_of(:password).is_at_least(8) }
    end

    context 'format' do
      it 'valid email' do
        is_expected.to allow_values('rails.last@foo.com',
                                    'rails@example.com',
                                    'RAILS@foo.COM',
                                    'A_US-ER@foo.bar.org',
                                    'alice+bob@baz.cn').for(:email)
      end
      it 'invalid email' do
        is_expected.to_not allow_values('user@example,com',
                                        'user_at_foo.org',
                                        'user.name@example.',
                                        'foo@bar_baz.com',
                                        'foo@bar+baz.com').for(:email)
      end
      it 'valid password' do
        is_expected.to allow_values('rails0123',
                                    'Rails0123',
                                    'a1' * 200).for(:password)
      end
      it 'invalid password' do
        is_expected.to_not allow_values(' ' * 8).for(:password)
      end
    end

    context 'uniquness' do #emailはbefore_saveが読み込めないためshoulda-matchersを使用しない
      let!(:user) { create(:user) }
      context 'email' do
        it '重複したメールアドレスは無効であること' do
          dup_user = build(:user, email: user.email)
          expect(dup_user).to_not be_valid
        end
        it '大文字と小文字は区別されないこと' do
          dup_user = build(:user, email: user.email.upcase)
          expect(dup_user).to_not be_valid
        end
      end

      context 'activation_token' do
        it '重複したactivation_tokenは無効であること' do
          dup_user = build(:user, activation_token: user.activation_token)
          expect(dup_user).to_not be_valid
        end
      end
    end
  end

  describe 'default' do
    let(:user) { create(:user) }
    it 'roleがreviewerであること' do
      expect(user.role).to eq('temporary')
    end

    it 'avatarのURLがデフォルトであること' do
      expect(user.avatar).to eq('https://pics.prcm.jp/a508a977c6fa9/84540173/png/84540173.png')
    end
  end

  describe 'methods' do
    context '#activate_attributes' do
      let!(:user) { create(:user) }
      it 'ユーザーを有効にすること' do
        expect(user.activate_attributes).to be_truthy
      end
    end
  end
end
