class AddIndexToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_index :notifications, [:notifiable_type, :notifiable_id]
  end
end
