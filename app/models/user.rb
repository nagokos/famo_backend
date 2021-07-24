class User < ApplicationRecord
  include JwtToken

  before_create :set_uuid
  before_save :email_downcase, if: -> { email_changed? }
  before_update :setup_activation, if: -> { email_changed? }
  after_update :send_activation_needed_email!, if: -> { previous_changes['email'].present? }

  has_one :profile, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :active_reviews, class_name: 'Review', foreign_key: 'reviewer_id', dependent: :nullify
  has_many :passive_reviews, class_name: 'Review', foreign_key: 'reviewee_id', dependent: :destroy

  authenticates_with_sorcery!

  EMAIL_FORMAT = /\A[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}\z/i
  PASSWORD_FORMAT = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,}+\z/i

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :birth_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/ }
  validates :avatar, presence: true
  validates :role, presence: true
  validates :introduction, length: { maximum: 400 }
  validates :email, uniqueness: true, presence: true, format: { with: EMAIL_FORMAT }
  validates :password, presence: true, length: { minimum: 8 }, format: { with: PASSWORD_FORMAT },
                       if: -> { new_record? || changes[:crypted_password] }
  validates :activation_token, uniqueness: true, allow_nil: true

  enum role: { reviewer: 0, player: 1, admin: 2 }

  def activate_attributes
    activate!
    update_column(:activation_token_expires_at, nil)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.destroy(other_user)
  end

  def follow?(other_user)
    following.include?(other_user)
  end

  def filter_reviews
    if reviewer?
      active_reviews
    else
      passive_reviews
    end
  end

  private

  def set_uuid
    self.id = loop do
      random_token = SecureRandom.urlsafe_base64(9)
      break random_token unless self.class.exists?(id: random_token)
    end
  end

  def email_downcase
    self.email = email.downcase
  end
end
