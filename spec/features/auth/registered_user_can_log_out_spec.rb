require 'rails_helper'

describe 'Registered user' do
  it 'can log out' do
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

    expect(current_path).to eq(dashboard_path)

    click_on 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You have logged out')
    expect(page).to have_content('Login')
  end
end
