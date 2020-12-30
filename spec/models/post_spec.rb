require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Input Validation' do  # (almost) plain English
    it 'cannot create post without any user' do
      expect {
        Post.create!(content: "Content")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
