teams = ['青森山田高校', 'ブランデュー弘前U-18']

teams.each do |team|
  Team.seed(
    name: team,
    prefecture_id: 1
  )
end