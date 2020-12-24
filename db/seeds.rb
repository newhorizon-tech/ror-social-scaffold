require 'humanize'

#Enter numbers

num_users = 30   #Number of Users
num_request = 8  #Number of random friend requests

##
range = (1..num_users)

# Create Users
range.each do |i|
  num = i.humanize.capitalize
  @user = User.new(name: "User #{num}",
             email: "#{num}@email.com",
             password: "pineapple",
             password_confirmation: "pineapple")
  @user.save
end

array = range.to_a


(0..num_request).each do |j|
  combo = array.sample(2)
  array = array - combo
  user_a = User.find(combo[0])
  user_b = User.find(combo[1])
  FriendshipRequest.create(request_sender: user_a, request_receiver: user_b)
end
