class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.decimal :rate, null: false, :precision => 2, :scale => 1
      t.date :watching_date
      t.integer :privacy, null: false, default: 0
      t.text :content, null: false
      t.string :reviewer_id, null: false
      t.string :reviewee_id, null: false

      t.timestamps
    end
    add_index :reviews, :reviewer_id
    add_index :reviews, :reviewee_id
  end
end
