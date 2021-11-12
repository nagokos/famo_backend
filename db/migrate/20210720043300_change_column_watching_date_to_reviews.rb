class ChangeColumnWatchingDateToReviews < ActiveRecord::Migration[6.1]
  def change
    rename_column :reviews, :watching_date, :game_date
    change_column_null :reviews, :game_date, false
  end
end
