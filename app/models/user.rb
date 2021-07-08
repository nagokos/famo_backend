class User < ApplicationRecord
  include JwtToken

  before_save :email_downcase, if: -> { email_changed? }
  before_update :setup_activation, if: -> { email_changed? }
  after_update :send_activation_needed_email!, if: -> { previous_changes["email"].present? }

  has_one :profile, dependent: :destroy

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

  private

  def email_downcase
    self.email = email.downcase
  end
end
