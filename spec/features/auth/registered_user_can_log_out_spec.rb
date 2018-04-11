require 'rails_helper'

describe 'Registered user' do
  it 'can log out' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    click_on 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('You have logged out')
    expect(page).to have_content('Login')
  end
end
