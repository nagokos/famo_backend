reviewer = User.find_by(email: 'rails@gmail.com')
reviewee = User.where(role: 'player').first
content = 'とても良いプレーでした。次戦も期待しています。' * 10

100.times do |index|
  reviewer.active_reviews.create!(
    reviewee_id: reviewee.id,
    game_date: Time.current.ago(index.days),
    rate: format('%10.1f', rand(1.0..5.0)).strip.to_f,
    content: content
  )
end