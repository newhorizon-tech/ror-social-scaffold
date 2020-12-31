require 'rails_helper'
RSpec.describe 'creating a post', type: :feature do
  before(:each) do
   current_user = User.create!(name: 'TestUser', email: 'testuser@email.com',
                password: 'pineapple', password_confirmation: 'pineapple')
  end
  it 'creates a valid post with content' do
    visit '/'
    within('#new_post') do
      fill_in 'content', with: 'test post'
    end
    click_button 'Save'
    test_post = find('p.post-content')
    expect(test_post).to have_content 'test post'
  end
end