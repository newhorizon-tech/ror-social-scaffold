class CreateFriendshipRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendship_requests do |t|
      t.belongs_to :request_receiver, foreign_key: { to_table: :users }
      t.belongs_to :request_sender, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
