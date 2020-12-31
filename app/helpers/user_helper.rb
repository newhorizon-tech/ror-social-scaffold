module UserHelper
  def relation_exists?(user1, user2)
    FriendshipRequest.where(
      user: user1, friend: user2
    ).or(FriendshipRequest.where(
           user: user2, friend: user1
         )).exists? or
      (user1.eql? user2)
  end
end
