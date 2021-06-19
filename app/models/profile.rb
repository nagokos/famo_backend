class Profile < ApplicationRecord
  belongs_to :group
  belongs_to :team

  validates :position, presence: true
  validates :uniform_number, presence: true
  validates :career, presence: true
end
