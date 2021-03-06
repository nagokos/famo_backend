class Team < ApplicationRecord
  belongs_to :prefecture
  has_many :profiles, dependent: :restrict_with_exception

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :prefecture }
end
