class FriendshipRequest < ApplicationRecord
  belongs_to :request_sender, class_name: 'User'
  belongs_to :request_receiver, class_name: 'User'

  scope :pending, -> { where(status: false) }
  scope :accepted, -> { where(status: true) }
end
