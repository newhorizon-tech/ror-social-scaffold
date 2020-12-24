class CreateFriendshipRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friendship_requests do |t|
      t.string :status, default: 'pending'
      
      t.references :request_receiver, foreign_key: { to_table: :users }
      t.references :request_sender, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
