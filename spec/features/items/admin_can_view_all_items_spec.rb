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

      click_on 'View all Accessories in Bike Shop'

      expect(current_path).to eq(admin_bike_shop_index_path)
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.status)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item3.title)
    end
  end
end
