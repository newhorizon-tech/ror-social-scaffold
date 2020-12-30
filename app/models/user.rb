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
    @request_list = FriendshipRequest.pending.where(request_receiver: self)
    @user_list = @request_list.map(&:request_sender)
  end

  def send_request(receiver)
    FriendshipRequest.create(request_receiver: receiver, request_sender: self)
  end

  def accept_request(sender)
    @request = FriendshipRequest.pending.where(request_receiver_id: id, request_sender_id: sender.id).first
    @request.status = true
    @request.save
  end

  def reject_request(sender)
    @request = FriendshipRequest.pending.where(request_receiver_id: id, request_sender_id: sender.id).first
    @request.destroy
  end

  def friend_list
    @relations = FriendshipRequest.accepted.where(
      request_receiver_id: id
    ).or(FriendshipRequest.accepted.where(
           request_sender_id: id
         ))
    friend_ids = @relations.distinct.pluck(:request_sender_id) + @relations.distinct.pluck(:request_receiver_id) - [id]
    User.where(id: friend_ids)
  end
end
