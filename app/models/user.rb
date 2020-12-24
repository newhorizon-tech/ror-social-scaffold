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
     notification_list = FriendshipRequest.pending.where(request_receiver_id: self.id)
  end

  def accept_request(sender)
    fr = FriendshipRequest.pending.where(request_receiver_id: self.id, request_sender_id: sender.id)
    FriendshipRequest.accept_request
  end


end
