FactoryBot.define do
  factory :review do
    rate { rand(1.0..5.0) }
    sequence(:game_date) { |n| Time.current.ago(n.days) }
    content { 'とても良いプレーでした' }
    reviewer { nil }
    reviewee { nil }
  end

  trait :high_review do
    rate { 5.0 }
  end

  trait :low_review do
    rate { 1.0 }
  end
end
