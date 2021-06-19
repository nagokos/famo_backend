class Team < ApplicationRecord
  belongs_to :prefecture

  validates :name, presence: true, uniqueness: { scope: :prefecture }
  validates :kind, presence: true

  enum kind: { high_school: 0, youth: 1 }
end
