class ChangeColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :avatar, from: nil, to: 'https://pics.prcm.jp/a508a977c6fa9/84540173/png/84540173.png'
    change_column_null :users, :avatar, false
  end
end
