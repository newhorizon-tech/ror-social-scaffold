class FriendshipRequest < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  scope :pending, -> { where(status: false) }
  scope :accepted, -> { where(status: true) }

  def self.accept_request(receiver, sender)
    @request = FriendshipRequest.pending.where(friend_id: receiver.id, user_id: sender.id).first
    @request.status = true
    @request.save
    FriendshipRequest.create(user: receiver, friend: sender, status: true)
  end

  def self.reject_request(receiver, sender)
    @request = FriendshipRequest.pending.where(friend_id: receiver.id, user_id: sender.id).first
    @request.destroy
  end
end
