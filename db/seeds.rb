require 'humanize'
require 'faker'

#Enter numbers

num_users = 40   #Number of Users
friend_requests = 10  #Number of friend requests
friends = 10   #Number of friends

##
range = (2..num_users+1)
array = range.to_a


#Create sample custom user
@custom_user = User.new(name: "user",
           email: "user@email.com",
           password: "pineapple",
           password_confirmation: "pineapple")
@custom_user.save
@custom_user.posts.create(content: Faker::Lorem.sentence(word_count: 12))


# Create Users
range.each do
  username = Faker::Name.first_name.capitalize
  @user = User.new(name: "#{username}",
             email: "#{username}@email.com",
             password: "pineapple",
             password_confirmation: "pineapple")
  @user.save
  @user.posts.create(content: Faker::Lorem.sentence(word_count: 12))
end


def friend(x, y)
  FriendshipRequest.create(request_receiver: x, request_sender: y)
  x.accept_request(y)
end

def onlyrequest(x,y)
  FriendshipRequest.create(request_receiver: x, request_sender: y)
end


(0..friend_requests).each do |i|
  combo = array.sample(1)
  array = array - [combo]
  user_a = @custom_user
  user_b = User.find(combo[0])
  onlyrequest(user_a, user_b)
end


(0..friends).each do |i|
  combo = array.sample(1)
  array = array - [combo]
  user_a = @custom_user
  user_b = User.find(combo[0])
  friend(user_a, user_b)
end
