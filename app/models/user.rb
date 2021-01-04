class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, class_name: 'FriendshipRequest', foreign_key: 'user_id'

  has_many :confirmed_friendships, -> { where status: true }, class_name: 'FriendshipRequest'
  has_many :friends, through: :confirmed_friendships

  def notifications
    @request_list = FriendshipRequest.pending.where(friend: self)
    @user_list = @request_list.map(&:user)
  end
end
