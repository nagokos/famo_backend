FactoryBot.define do
  factory :profile do
    official_number { 10 }
    group { Group.first }
    team { Team.first }
    user
  end
end
