require 'rails_helper'
RSpec.describe 'creating a post', type: :feature do
  before(:each) do
    User.create!(name: 'TestUser', email: 'testuser@email.com',
                 password: 'pineapple', password_confirmation: 'pineapple')
    do_login('testuser@email.com', 'pineapple')
  end
  it 'creates a valid post with content' do
    visit '/'
    within('#new_post') do
      fill_in 'post_content', with: 'test post'
    end
    click_button 'Save'
    test_post = find('p.post-content')
    expect(test_post).to have_content 'test post'
  end
  it 'gives an error message when no content is provided' do
    visit '/'
    within('#new_post') do
      fill_in 'post_content', with: ''
    end
    click_button 'Save'
    error = find('p.errors')
    expect(error).to have_content "Post could not be saved. Content can't be blank"
  end
end
