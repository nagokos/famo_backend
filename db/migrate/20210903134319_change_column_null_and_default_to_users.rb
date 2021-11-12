class ChangeColumnNullAndDefaultToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :avatar, true
    change_column_default :users, :avatar, nil
  end
end
