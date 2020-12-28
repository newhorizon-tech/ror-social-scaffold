require 'humanize'
require 'faker'

#Enter numbers

num_users = 40   #Number of Users
num_request = 30  #Number of users getting random friend requests

##
range = (1..num_users)
array = range.to_a

# Create Users
range.each do
  username = Faker::Name.first_name.capitalize
  @user = User.new(name: "#{username}",
             email: "#{username}@email.com",
             password: "pineapple",
             password_confirmation: "pineapple")
  @user.save
end


def friend(x, y)
  FriendshipRequest.create(request_receiver: x, request_sender: y)
end


(0..num_request).each do
  combo = array.sample(4)
  # array = array - [combo[0]]
  user_a = User.find(combo[0])
  user_b = User.find(combo[1])
  user_c = User.find(combo[2])
  user_d = User.find(combo[3])
  friend(user_a, user_b)
  friend(user_a, user_c)
  friend(user_a, user_d)
end
