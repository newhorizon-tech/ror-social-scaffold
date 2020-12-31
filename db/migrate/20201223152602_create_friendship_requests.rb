class CreateFriendshipRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendship_requests do |t|
      t.boolean :status, default: false

      t.integer :user_id, null: false
      t.integer :friend_id, null: false
      t.timestamps
    end
    add_foreign_key "friendship_requests", "users", column: "user_id"
    add_foreign_key "friendship_requests", "users", column: "friend_id"
  end
end
