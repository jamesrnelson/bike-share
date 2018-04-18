require 'rails_helper'

describe 'Registered user' do
  describe 'visits homepage' do
    it 'they can log in' do
      user = create(:user)

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)
      fill_in 'name', with: user.name
      fill_in 'username', with: user.username
      fill_in 'password', with: user.password

      within('.form') do
        click_on 'Login'
      end

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Logged in as: #{user.name}")
      expect(page).to have_content('Logout')
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.username)
    end
  end
end
