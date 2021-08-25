FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    birth_date { Faker::Date.birthday.strftime('%F') }
    email { Faker::Internet.unique.email }
    password { 'Foobar0123' }
  end

  trait :invalid do
    name { nil }
  end
end
