groups = ['EAST', 'WEST']

groups.each do |group|
  Group.seed(
    name: group,
    category_id: 1
  )
end