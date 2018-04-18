require 'rails_helper'

describe 'Registered user' do
  describe 'visits user dashboard' do
    it 'they can modify their account info' do
      user = create(:user)

      visit root_path

      click_on "Login"

      expect(current_path).to eq(login_path)
      fill_in "name", with: user.name
      fill_in "username", with: user.username
      fill_in "password", with: user.password

      within('.form') do
        click_on "Login"
      end

      click_on 'Update Profile Information'

      expect(current_path).to eq(edit_user_path(user))

      fill_in "user[name]", with: "Bob"
      fill_in "user[username]", with: "bobbyboy"
      fill_in "user[password]", with: "password"

      click_on "Update Account"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Your profile information has been updated")
      expect(page).to have_content("Bob")
      expect(page).to_not have_content(user.name)
    end
  end
end

describe 'Admin' do
  describe 'visits admin dashboard' do
    it 'they can modify their account info' do
      admin = create(:admin)

      visit root_path

      click_on "Login"

      expect(current_path).to eq(login_path)
      fill_in "name", with: admin.name
      fill_in "username", with: admin.username
      fill_in "password", with: admin.password

      within('.form') do
        click_on "Login"
      end

      click_on 'Update Profile Information'

      expect(current_path).to eq(edit_user_path(admin))

      fill_in "user[name]", with: "Bob"
      fill_in "user[username]", with: "bobbyboy"
      fill_in "user[password]", with: "password"

      click_on "Update Account"

      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Your profile information has been updated")
      expect(page).to have_content("Bob")
    end
  end
end
