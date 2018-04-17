require 'rails_helper'

describe 'Admin' do
  describe 'visits admin dashboard' do
    it 'they can click a link and view all items' do
      admin = create(:admin)
      item1, item2, item3 = create_list(:item, 3)

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)
      fill_in 'name', with: admin.name
      fill_in 'username', with: admin.username
      fill_in 'password', with: admin.password

      within('.form') do
        click_on 'Login'
      end

      visit admin_bike_shop_index_path

      click_on "Edit #{item1.title}"

      expect(current_path).to eq(edit_admin_bike_shop_path(item1))

      fill_in :'item[title]', with: 'Sweet Wheels'
      fill_in :'item[description]', with: 'Make all your friends super jealous'
      fill_in :'item[price]', with: 24.99

      click_on 'Update Accessory'

      expect(current_path).to eq(admin_bike_shop_index_path)
      expect(page).to have_content('Make all your friends super jealous')
      expect(page).to_not have_content(item1.title)
    end
  end
end
