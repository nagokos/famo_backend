class ChangeColumnToNullBirthDateOfUser < ActiveRecord::Migration[6.1]
  def up
    change_column_null :users, :birth_date, true
  end

  def down
    change_column_null :users, :birth_date, false
  end
end
