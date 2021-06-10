class Category < ApplicationRecord
  belongs_to :league
  has_many :groups
end
