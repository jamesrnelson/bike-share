require 'rails_helper'

describe 'Register user' do
  describe 'visits homepage' do
    it 'they can log in' do
      user = create(:user)

      visit '/'

      click_on "Log In"

      expect(current_path).to eq(login_path)
      fill_in "name", with: user.name
      fill_in "username", with: user.username
      fill_in "password", with: user.password

      click_on "Log In"

      expect(current_path).to eq(user_path(user))

      expect(page).to have_content("Welcome, #{user.username}")
      expect(page).to have_content("Logout")
    end
  end
end
