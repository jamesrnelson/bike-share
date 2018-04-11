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
end
