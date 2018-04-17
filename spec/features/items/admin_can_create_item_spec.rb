require 'rails_helper'

describe 'Admin' do
  describe 'visits admin/bike-shop/new' do
    it 'they can create a new item' do
      admin = create(:admin)

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)
      fill_in 'name', with: admin.name
      fill_in 'username', with: admin.username
      fill_in 'password', with: admin.password

      within('.form') do
        click_on 'Login'
      end

      click_on 'Add New Accessory'

      expect(current_path).to eq(new_admin_bike_shop_path)

      fill_in :'item[title]', with: 'Sweet Wheels'
      fill_in :'item[description]', with: 'Make all your friends jealous'
      fill_in :'item[price]', with: 24.99

      click_on 'Add Accessory'

      expect(current_path).to eq(admin_bike_shop_index_path)
      expect(page).to have_content('Sweet Wheels')
      expect(page).to have_content('Make all your friends jealous')
      expect(page).to have_content('24.99')
    end
  end
end
