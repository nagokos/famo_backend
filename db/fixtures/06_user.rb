User.seed(
  name: Faker::Name.name,
  email: 'rails@gmail.com',
  birth_date: Time.zone.now.strftime("%F"),
  password: 'foobar1111'
)

200.times do
  name = Faker::Name.name
  email = Faker::Internet.unique.email
  birth_date = Time.zone.now.strftime("%F")
  password = 'foobar1111'
  User.seed(
    name: name,
    email: email,
    birth_date: birth_date,
    password: password
  )
end

User.limit(100).each do |user|
  user.update(role: "player")
  Profile.seed(
    position: (0..3).to_a.shuffle.first,
    official_number: (1..99).to_a.shuffle.first,
    user_id: user.id,
    group_id: Group.pluck(:id).shuffle.first,
    team_id: Team.pluck(:id).shuffle.first,
    rate: format('%10.2f', rand(1.0..5.0)).strip.to_f
  )
end

user = User.find_by!(email: "rails@gmail.com")
users = User.where.not(email: user.email)
users.each do |other_user|
  user.follow(other_user)
  user.followers << other_user
end
