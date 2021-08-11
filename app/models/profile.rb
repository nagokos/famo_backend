class Profile < ApplicationRecord
  belongs_to :group
  belongs_to :team
  belongs_to :user

  validates :position, presence: true
  validates :official_number, presence: true, numericality: true
  validates :practice_number, numericality: true, allow_blank: true
  validates :career, length: { maximum: 50 }
  validates :rate, presence: true

  enum position: { GK: 0, DF: 1, MF: 2, FW: 3 }

  def self.player_team
    all.map do |profile|
      team_id = profile.team_id
      Team.find(team_id)
    end
  end
end
