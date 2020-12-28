class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :request_senders, class_name: 'FriendshipRequest', foreign_key: 'request_sender_id'
  has_many :request_receivers, class_name: 'FriendshipRequest', foreign_key: 'request_receiver_id'


  def notifications
    @request_list = FriendshipRequest.pending.where(request_receiver:self)
    @user_list = @request_list.map do |list_item|
      list_item.request_sender
    end
  end

  def accept_request(sender)
    @request = FriendshipRequest.pending.where(request_receiver_id: self.id, request_sender_id: sender.id).first
    @request.status = 'accepted'
    @request.save
  end

  def reject_request(sender)
    @request = FriendshipRequest.pending.where(request_receiver_id: self.id, request_sender_id: sender.id).first
    @request.status = 'rejected'
    @request.save
  end

  def friend_ids
    @relations = FriendshipRequest.accepted.where(request_receiver_id: self.id).or(FriendshipRequest.accepted.where(request_sender_id: self.id))
    @relations.distinct.pluck(:request_sender_id) + @relations.distinct.pluck(:request_receiver_id) - [self.id]
  end

  def friend_list
    User.where(id: self.friend_ids)
  end
end
