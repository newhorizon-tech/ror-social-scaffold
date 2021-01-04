# Model FriendshipRequest (Through table)

## friendship_requests (1 table)

| attribute | properties|
| -- | -- |
user_request_sender_id |FOREIGN KEY, INTEGER|
user_request_reciever _id |FOREIGN KEY, INTEGER
status | STRING

The variable status can have three values: 'pending', 'accepted', and 'rejected'

-------
## Alternate  scenarios

2 tables - friendship_request, friend_list

3 tables - friendship_request, friend_list, notifications
