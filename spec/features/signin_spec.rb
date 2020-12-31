require 'rails_helper'

RSpec.describe 'the signin process', type: :feature do
  before :each do
    User.create!(name: 'test_user',
                 email: 'test_user@email.com',
                 password: 'pineapple',
                 password_confirmation: 'pineapple')
  end

  it 'signs me in' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'test_user@email.com'
      fill_in 'Password', with: 'pineapple'
    end
    click_button 'Log in'
    notice_text = find('div.notice').text
    expect(notice_text).to have_content 'Signed in successfully.'
  end

  it 'displays error message when incorrect input is entered' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'incorrect@email.com'
      fill_in 'Password', with: 'pineapple'
    end
    click_button 'Log in'
    notice_text = find('div.alert').text
    expect(notice_text).to have_content 'Invalid Email or password.'
  end
end
