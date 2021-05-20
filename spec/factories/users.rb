FactoryBot.define do
  factory :user do
    sequence(:first_name, 'first_name_1')
    sequence(:last_name, 'last_name_1')
    birth_date { '2000-01-01' }
    role { 0 }
    introduction { '' }
    sequence(:email, 'rails_1@example.com')
    password { 'Foobar0123' }
  end
end
