class AddUniqueIndexToReviews < ActiveRecord::Migration[6.1]
  def change
    add_index :reviews, [:reviewer_id, :reviewee_id, :game_date], unique: true
  end
end
