class FriendshipRequest < ApplicationRecord
    belongs_to :request_sender, class_name: 'User'
    belongs_to :request_receiver, class_name: 'User'

    def accept_request(sender)
      self.status = 'accepted'
    end

    def reject_request
      self.status = 'rejected'
    end

    scope :pending, -> { where(status: 'pending')}
    scope :accepted, -> { where(status: 'accepted')}
end
