require 'rails_helper'

# class User < ApplicationRecord
#   include JwtToken
#   mount_uploader :avatar, AvatarUploader

#   before_validation :set_password, if: -> { new_record? }
#   before_save :email_downcase, if: -> { email_changed? }
#   before_create :set_uuid
#   before_update :setup_activation, if: -> { email_changed? }
#   after_update :send_activation_needed_email!, if: -> { previous_changes['email'].present? }

#   has_one :profile, dependent: :destroy

#   has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
#   has_many :following, through: :active_relationships, source: :followed
#   has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
#   has_many :followers, through: :passive_relationships, source: :follower

#   has_many :active_reviews, class_name: 'Review', foreign_key: 'reviewer_id', dependent: :nullify
#   has_many :passive_reviews, class_name: 'Review', foreign_key: 'reviewee_id', dependent: :destroy

#   has_many :authentications, dependent: :destroy
#   accepts_nested_attributes_for :authentications

#   authenticates_with_sorcery!

#   EMAIL_FORMAT = /\A[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}\z/i
#   PASSWORD_FORMAT = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}+\z/i

#   validates :name, presence: true, length: { maximum: 30 }
#   validates :birth_date, format: { with: /\d{4}-\d{2}-\d{2}/ }, allow_blank: true
#   validates :role, presence: true
#   validates :introduction, length: { maximum: 400 }
#   validates :email, uniqueness: true, presence: true, format: { with: EMAIL_FORMAT }
#   validates :password, presence: true, length: { minimum: 8 }, format: { with: PASSWORD_FORMAT },
#                        if: -> { new_record? || changes[:crypted_password] }
#   validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
#   validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
#   validates :activation_token, uniqueness: true, allow_nil: true
#   validates :reset_password_token, uniqueness: true, allow_nil: true

#   enum role: { reviewer: 0, player: 1, admin: 2 }

#   scope :cache_profile, -> { includes(profile: [team: :prefecture, group: [category: :league]]) }

#   def activate_attributes
#     activate!
#     update_column(:activation_token_expires_at, nil)
#   end

#   def follow(other_user)
#     following << other_user
#   end

#   def unfollow(other_user)
#     following.destroy(other_user)
#   end

#   def follow?(other_user)
#     following.include?(other_user)
#   end

#   def role_reviews
#     # 管理者は想定していない
#     if reviewer?
#       active_reviews.joins(:reviewee).cache_profile.merge(User.where(role: 'player'))
#     else
#       passive_reviews.includes(:reviewee, reviewer: [profile: [team: :prefecture, group: [category: :league]]])
#     end
#   end

#   def role_and_game_date_reviews
#     if reviewer?
#       active_reviews.joins(:reviewee).merge(User.where(role: 'player'))
#     else
#       passive_reviews
#     end
#   end

#   private

#   def set_uuid
#     self.id = loop do
#       random_token = SecureRandom.urlsafe_base64(9)
#       break random_token unless self.class.exists?(id: random_token)
#     end
#   end

#   def set_password
#     self.password_confirmation = password
#   end

#   def email_downcase
#     self.email = email.downcase
#   end
# end

RSpec.describe User, type: :model do
  describe 'association' do
    context 'has_many' do
      it { is_expected.to have_many(:active_relationships) }
      it { is_expected.to have_many(:following) }
      it { is_expected.to have_many(:passive_relationships) }
      it { is_expected.to have_many(:followers) }
      it { is_expected.to have_many(:active_reviews) }
      it { is_expected.to have_many(:passive_reviews) }
      it { is_expected.to have_many(:authentications) }
    end

    context 'has_one' do
      it { is_expected.to have_one(:profile) }
    end
  end

  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:role) }
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'length' do
      it { is_expected.to validate_length_of(:name).is_at_most(30) }
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

      context 'reset_password_token' do
        before { user.generate_reset_password_token! }
        it '重複したreset_password_tokenは無効であること' do
          dup_user = build(:user, reset_password_token: user.reset_password_token)
          expect(dup_user).to_not be_valid
        end
      end
    end
  end

  describe 'default' do
    let(:user) { create(:user) }
    it 'roleがreviewerであること' do
      expect(user.role).to eq('reviewer')
    end
  end

  describe 'methods' do
    let(:user) { create(:user) }

    describe 'activate_attributes' do
      before { user.activate_attributes }

      it 'ユーザーをアクティブにする' do
        expect(user.activation_state).to eq('active')
      end

      it 'トークン有効期限をnilにする' do
        expect(user.activation_token_expires_at).to eq(nil)
      end
    end

    describe 'relationship' do
      let!(:user) { create(:user) }
      let!(:user2) { create(:user) }

      describe 'follow' do
        it 'ユーザーをフォローすること' do
          user.follow(user2)
          expect(user.following).to include(user2)
        end
      end

      describe 'unfollow' do
        before { user.follow(user2) }
        it 'ユーザーをアンフォローすること' do
          user.unfollow(user2)
          expect(user.following).to_not include(user2)
        end
      end

      describe 'follow?' do
        context 'フォローしている場合' do
          it 'trueを返す' do
            user.follow(user2)
            expect(user.follow?(user2)).to be_truthy
          end
        end

        context 'フォローしていない場合' do
          it 'falseを返す' do
            expect(user.follow?(user2)).to be_falsey
          end
        end
      end

      describe 'role_reviews, role_and_game_date_reviews' do
        let!(:player) { create(:user, :player) }
        let!(:user2) { create(:user) }
        let!(:player_review) { create(:review, reviewer: user, reviewee: player) }
        let!(:public_review) { create(:review, reviewer: user, reviewee: user2) }

        context 'レビュワーの場合' do
          it '選手のみのレビューがあること' do
            expect(user.role_reviews).to include(player_review)
            expect(user.role_reviews).to_not include(public_review)
          end
        end

        context 'レビューイの場合' do
          it '全ユーザーのレビューがあること' do
            expect(player.role_reviews).to include(player_review)
          end
        end
      end
    end
  end
end
