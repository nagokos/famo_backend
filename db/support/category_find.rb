def find_category_id(league, category)
  League.find_by(name: league).categories.find_by(name: category).id
end