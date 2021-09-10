FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'Foobar0123' }
  end

  trait :invalid do
    name { nil }
  end
end
