require 'rails_helper'

describe 'Admin' do
  describe 'visits indiviual order page' do
    it 'they see complete order information including user info' do
      DatabaseCleaner.clean
      user = create(:user)
      order = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      item = create(:item)
      order_item = order.order_items.create!(item_id: item.id, quantity: 3)

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

      visit order_path(order)

      expect(page).to have_content(order.created_at)
      expect(page).to have_content(order.fullname)
      expect(page).to have_content(order.address)
      expect(page).to have_content(item.title)
      expect(page).to have_content(order.total_quantity)
      expect(page).to have_content(order_item.quantity)
      expect(page).to have_content(order.item_subtotal(item))
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end
  end
end
