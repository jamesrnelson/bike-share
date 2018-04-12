require 'rails_helper'

describe 'Visitor' do
  it 'cannot view another users cart' do
    user = create(:user)
    item1, item2, item3 = create_list(:item, 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit bike_shop_path

    click_on item1.title
    click_on item2.title
    click_on 'Logout'

    visit bike_shop_path

    click_on item3.title

    visit cart_path

    expect(page).to_not have_content(item1.title)
    expect(page).to_not have_content(item2.title)
    expect(page).to have_content(item3.title)
  end

  it 'cannot view another users profile information' do
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

    click_on 'Logout'

    expect(page).to_not have_content(user.name)
    expect(page).to_not have_content(user.username)
  end
end
