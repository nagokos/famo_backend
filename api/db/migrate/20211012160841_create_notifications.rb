class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :notifiable_type, null: false, default: 0
      t.integer :notifiable_id
      t.string :visitor_id
      t.string :visited_id
      t.integer :action, null: false, default: 0
      t.boolean :checked, null: false, default: 0

      t.timestamps
    end
    add_index :notifications, :notifiable_id
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
  end
end
