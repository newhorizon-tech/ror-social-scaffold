require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:test_user) do
    User.create(name: 'TestUser', email: 'testuser@email.com',
                password: 'pineapple', password_confirmation: 'pineapple')
  end
  it 'cannot create post without any user' do
    expect do
      Post.create!(content: 'Content')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
  it 'cannot create post without any content' do
    test_post = test_user.posts.create(content: '')
    expect(test_post).to_not be_valid
  end
  it 'create a valid post with content' do
    test_post = test_user.posts.create(content: 'Its a post')
    expect(test_post).to be_valid
  end
end
