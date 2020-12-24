class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :sent_requests, class_name: 'FriendshipRequest', foreign_key: 'request_sender_id'
  has_many :receiver_requests, class_name: 'FriendshipRequest', foreign_key: 'request_receiver_id'
end

