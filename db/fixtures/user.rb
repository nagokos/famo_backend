User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'rails@gmail.com',
  birth_date: Time.zone.now.strftime("%F"),
  password: 'foobar1111'
)

20.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.unique.email
  birth_date = Time.zone.now.strftime("%F")
  password = 'foobar1111'
  user = User.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    birth_date: birth_date,
    password: password
  )
end

user = User.find_by!(email: "rails@gmail.com")
users = User.where.not(email: user.email)
users.each do |other_user|
  user.follow(other_user)
  user.followers << other_user
end
