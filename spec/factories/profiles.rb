FactoryBot.define do
  factory :profile do
    official_number { rand(1..100) }
    group { Group.all.shuffle.first }
    team { Team.all.shuffle.first }
    rate { 0 }
    position { 'GK' }
    user
  end
end
