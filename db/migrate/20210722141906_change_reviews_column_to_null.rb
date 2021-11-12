class ChangeReviewsColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :reviews, :reviewer_id, true
  end

  def down
    change_column_null :reviews, :reviewer_id, false
  end
end
