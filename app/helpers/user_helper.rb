module UserHelper
  def relation_exists?(user1, user2)
    FriendshipRequest.where(
      request_sender: user1, request_receiver: user2
    ).or(FriendshipRequest.where(
           request_sender: user2, request_receiver: user1
         )).exists? or
      (user1.eql? user2)
  end
end
