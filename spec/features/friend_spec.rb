require 'rails_helper'
RSpec.describe 'Friends', js: true, type: :feature do
  before(:each) do
    User.create!(name: 'User One', email: 'userone@email.com',
                 password: 'pineapple', password_confirmation: 'pineapple')
    User.create!(name: 'User Two', email: 'usertwo@email.com',
                 password: 'pineapple', password_confirmation: 'pineapple')
    do_login('userone@email.com', 'pineapple')
  end
  it 'shows a message when a friend request is sent' do
    visit '/users'
    click_link 'Send Friend Request'
    message = find('div.notice').text
    expect(message).to have_content 'Your friend request has been sent to User Two!'
  end

  it 'shows a message when a friend request is accepted' do
    visit '/users'
    click_link 'Send Friend Request'
    within('nav') { click_link 'Sign out' }
    do_login('usertwo@email.com', 'pineapple')
    within('nav') { click_link 'Notifications' }
    click_link 'Accept Friend Request'
    message = find('div.notice').text
    expect(message).to have_content 'User One is now your friend!'
  end
end
