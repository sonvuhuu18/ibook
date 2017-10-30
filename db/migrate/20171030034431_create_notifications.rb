class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :notified_by_id
      t.string :notice_type
      t.string :book_id
      t.string :request_status
      t.integer :review_id
      t.boolean :is_read, default: false

      t.timestamps
    end

    add_index :notifications, :user_id
  end
end
