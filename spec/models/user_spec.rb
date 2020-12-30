require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Input Validation' do  # (almost) plain English
    it 'cannot create user if email is invalid' do
      expect {
        User.create!(name: 'User', email: "invalidemail",
                    password: 'password',
                    password_confirmation: 'password')
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'cannot create user if password is less than 6 characters' do
      expect {
        User.create!(name: 'User', email: "valid@email.com",
                    password: '12345',
                    password_confirmation: '12345')
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'cannot create user if name is not provided' do
      expect {
        User.create!(email: "valid@email.com",
                    password: '12345',
                    password_confirmation: '12345')
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'cannot create user if name is longer than 20 characters' do
      expect {
        long_name = 'longname' * 4
        User.create!(name: long_name, email: "valid@email.com",
                    password: '12345',
                    password_confirmation: '12345')
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'cannot user with duplicate email' do
      expect {
        User.create!(name: 'user1', email: "duplicate@email.com",
                    password: '123456',
                    password_confirmation: '123456')

        User.create!(name: 'user1', email: "duplicate@email.com",
                    password: '123456',
                    password_confirmation: '123456')
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

  end
end
