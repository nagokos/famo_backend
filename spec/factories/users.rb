FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'Foobar0123' }
  end

  trait :invalid do
    name { nil }
  end

  trait :player do
    role { 'player' }
    birth_date { Time.current.ago(16.years) }
    after(:build) do |user|
      create(:profile, rate: 3.0, user: user)
    end
  end

  trait :high_rate do
    role { 'player' }
    birth_date { Time.current.ago(16.years) }
    after(:build) do |user|
      create(:profile, rate: 5.0, user: user)
    end
  end

  trait :low_rate do
    role { 'player' }
    birth_date { Time.current.ago(16.years) }
    after(:build) do |user|
      create(:profile, rate: 1.0, user: user)
    end
  end
end
