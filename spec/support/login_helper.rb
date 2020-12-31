require 'rails_helper'
module LoginHelper
  def do_login(email, password)
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
    end
    click_button 'Log in'
  end
end
