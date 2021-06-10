class League < ApplicationRecord
  has_many :categories

  validates :name, presence: true
end
