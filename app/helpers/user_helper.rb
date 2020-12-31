module UserHelper
  def relation_exists?(user1, user2)
    FriendshipRequest.where(
      user: user1, friend: user2
    ).or(FriendshipRequest.where(
           user: user2, friend: user1
         )).exists? or
      (user1.eql? user2)
  end

  def request_button(current_user, user)
    if relation_exists?(current_user, user)
      'd-none'
    else
      'btn-custom'
    end
  end
end
