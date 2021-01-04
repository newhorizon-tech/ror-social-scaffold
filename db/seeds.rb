require 'humanize'
require 'faker'

#Enter numbers

num_users = 20   #Number of Users
friend_requests = 5  #Number of friend requests
friends = 5   #Number of friends

##
range = (2..num_users)
array = range.to_a


#Create sample custom user
@custom_user = User.create!(name: "user",
           email: "user@email.com",
           password: "pineapple",
           password_confirmation: "pineapple")
@custom_user.posts.create!(content: Faker::Lorem.sentence(word_count: 12))


# Create Users
range.each do
  username = Faker::Name.first_name.capitalize
  @user = User.create!(name: "#{username}",
             email: "#{username}@email.com",
             password: "pineapple",
             password_confirmation: "pineapple")
  @user.posts.create!(content: Faker::Lorem.sentence(word_count: 12))
end


def friend(x, y)
  FriendshipRequest.create!(friend: x, user: y)
  FriendshipRequest.accept_request(x,y)
end

def onlyrequest(x,y)
  FriendshipRequest.create!(friend: x, user: y)
end


(0..friend_requests).each do |i|
  combo = array.sample(1)
  array = array - [combo]
  user_a = @custom_user
  user_b = User.find(combo[0])
  onlyrequest(user_a, user_b)
end

#
# (0..friends).each do |i|
#   combo = array.sample(1)
#   array = array - [combo]
#   user_a = @custom_user
#   user_b = User.find(combo[0])
#   friend(user_a, user_b)
# end
