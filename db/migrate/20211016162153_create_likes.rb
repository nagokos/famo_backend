class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.string :user_id, null: false
      t.references :review, null: false, foreign_key: true

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, [:user_id, :review_id], unique: true
  end
end
