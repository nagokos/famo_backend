class Review < ApplicationRecord
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewee, class_name: 'User'

  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :game_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/ }
  validates :privacy, presence: true
  validates :content, presence: true, length: { maximum: 10_000 }

  enum privacy: { published: 0, player_only: 1 }

  scope :not_player, -> { where.not(privacy: 'player_only') }
  scope :conditions_shuffle, -> { where('LENGTH(content) >= 80').order('RAND()').limit(4) }
end
