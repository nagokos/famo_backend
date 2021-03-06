reviewer = User.find_by(email: 'rails@gmail.com')
reviewee = User.where(role: 'player').first
content = 'とても良いプレーでした。次戦も期待しています。' * 15

100.times do |index|
  review = Review.create(
    reviewer_id: reviewer.id,
    reviewee_id: reviewee.id,
    game_date: Time.current.ago(index.days),
    rate: format('%10.1f', rand(1.0..5.0)).strip.to_f,
    content: content
  )
  Notification.seed(
    visitor_id: review.reviewer_id,
    visited_id: review.reviewee_id
  )
end
