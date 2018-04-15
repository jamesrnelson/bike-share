require 'rails_helper'

describe 'Admin' do
  describe 'visits admin dashboard' do
    it 'they see a list of all orders and total number of each order status' do
      order1 = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      order2 = user.orders.create!(fullname: 'Peter Smith', address: '400 Spencer St., Longmont, CO 80501', status: 1)
      order3 = user.orders.create!(fullname: 'Bob Ross', address: '1000 Colors St., Magical Land, CO 1000', status: 2)
      order4 = user.orders.create!(fullname: 'Another Name', address: '600 Colors St., Magical Land, CO 1000', status: 3)
      item1, item2, item3 = create_list(:item, 3)
      order1.order_items.create!(item_id: item1.id, quantity: 3)
      order2.order_items.create!(item_id: item2.id, quantity: 1)
      order3.order_items.create!(item_id: item3.id, quantity: 2)
      order4.order_items.create!(item_id: item3.id, quantity: 2)
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

      visit admin_dashboard_path

      expect(page).to have_content(order1.fullname)
      expect(page).to have_content(order2.fullname)
      expect(page).to have_content(order3.fullname)
      expect(page).to have_content(order4.fullname)
      expect(page).to have_content('Ordered: 1')
      expect(page).to have_content('Completed: 1')
      expect(page).to have_content('Paid: 1')
      expect(page).to have_content('Cancelled: 1')
    end
  end
end
