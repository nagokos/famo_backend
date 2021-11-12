namespace :rate do
  desc '毎週水曜日にレートを計算する'
  task week_rate: :environment do
    User.where(role: 'player').find_each do |user|
      average = if user.passive_reviews.any?
                  user.passive_reviews.average(:rate)
                else
                  0
                end
      user.profile.update!(rate: average)
    end
  end
end
