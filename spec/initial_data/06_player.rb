50.times do
  User.seed(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: 'foobar1111',
    role: 'player',
    birth_date: Time.current.ago(16.years)
  )
end

User.all.each do |user|
  Profile.seed(
    user_id: user.id,
    team_id: Team.all.shuffle.first.id,
    group_id: Group.all.shuffle.first.id,
    official_number: rand(1..100),
    position: ['GK', 'DF'].shuffle.first,
    rate: format('%10.2f', rand(1.0..5.0)).strip.to_f
  )
end