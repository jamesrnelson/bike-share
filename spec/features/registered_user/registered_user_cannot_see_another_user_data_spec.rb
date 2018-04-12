require 'rails_helper'

describe 'Registered user' do
  it 'cannot view another users cart' do
    user1,user2 = create_list(:user, 2)
    item1, item2, item3 = create_list(:item, 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit bike_shop_path

    click_on item1.title
    click_on item2.title
    click_on 'Logout'

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit bike_shop_path

    click_on item3.title

    visit cart_path

    expect(page).to_not have_content(item1.title)
    expect(page).to_not have_content(item2.title)
    expect(page).to have_content(item3.title)
  end

  it 'cannot view another users profile information' do
    user1,user2 = create_list(:user, 2)

    visit root_path

    click_on 'Login'

    expect(current_path).to eq(login_path)
    fill_in 'name', with: user1.name
    fill_in 'username', with: user1.username
    fill_in 'password', with: user1.password

    within('.form') do
      click_on 'Login'
    end

    click_on 'Logout'

    visit root_path

    click_on 'Login'

    expect(current_path).to eq(login_path)
    fill_in 'name', with: user2.name
    fill_in 'username', with: user2.username
    fill_in 'password', with: user2.password

    within('.form') do
      click_on 'Login'
    end

    expect(page).to_not have_content(user1.name)
    expect(page).to_not have_content(user1.username)
  end
end
