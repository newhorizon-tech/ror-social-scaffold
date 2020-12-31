class CreateFriendshipRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendship_requests do |t|
      t.boolean :status, default: false

      t.references :user, foreign_key: { to_table: :users }
      t.references :friend, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
