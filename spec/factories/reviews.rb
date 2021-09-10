FactoryBot.define do
  factory :review do
    rate { 3.0 }
    sequence(:game_date) { |n| Time.current.ago(n.days) }
    content { 'とても良いプレーでした' }
    reviewer { nil }
    reviewee { nil }
  end
end
