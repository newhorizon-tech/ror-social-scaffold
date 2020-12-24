class FriendshipRequest < ApplicationRecord
    belongs_to :request_sender, class_name: 'User'
    belongs_to :request_receiver, class_name: 'User'


    scope :pending, -> { where(status: 'pending')}
    scope :accepted, -> { where(status: 'accepted')}
end
