require 'rails_helper'

RSpec.describe 'the signup process', type: :feature do
  it 'successfully signs up a new user' do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Name', with: 'User'
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: 'pineapple'
      fill_in 'Password confirmation', with: 'pineapple'
    end
    click_button 'Sign up'
    notice_text = find('div.notice').text
    expect(notice_text).to have_content 'Welcome! You have signed up successfully.'
  end
end
