FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birth_date { Faker::Date.birthday.strftime('%F') }
    email { Faker::Internet.unique.email }
    password { 'Foobar0123' }
  end

  trait :invalid do
    first_name { nil }
  end

  trait :expired do
    activation_token_expires_at { Time.zone.now.ago(2.day) }
  end
end
