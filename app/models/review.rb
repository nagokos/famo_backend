class Review < ApplicationRecord
  belongs_to :reviewer, class_name: 'User'
  belongs_to :reviewee, class_name: 'User'

  validates :rate, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :game_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/ }, uniqueness: { scope: %i[reviewer reviewee] }
  validates :privacy, presence: true
  validates :content, presence: true, length: { maximum: 10_000 }

  enum privacy: { published: 0, player_only: 1 }

  scope :desc, -> { order(created_at: :desc) }
  scope :game_desc, -> { order(game_date: :desc) }
  scope :game_asc, -> { order(game_date: :asc) }
  scope :rating, -> { order(rate: :desc) }
  scope :game_select_day, ->(day) { where(game_date: day.all_day) }
  scope :everyone, -> { where(privacy: 'published') }
  scope :require_reviewer, -> { where.not(reviewer_id: nil) }
  scope :conditions_shuffle, -> { where('LENGTH(content) >= 80').order('RAND()').limit(4) }
  scope :cache_profile, -> { includes(reviewer: :profile, reviewee: { profile: [team: :prefecture, group: { category: :league }] }) }
end
