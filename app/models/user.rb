class User < ApplicationRecord
  before_validation :set_password_confirmation

  authenticates_with_sorcery!

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :avatar, presence: true
  validates :birth_date, presence: true
  validates :role, presence: true
  validates :introduction, length: { maximum: 10_000 }
  validates :email, uniqueness: true, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})\z/i }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  enum role: { reviewer: 0, player: 1, admin: 2 }

  private

  def set_password_confirmation
    self.password_confirmation = password
  end
end
