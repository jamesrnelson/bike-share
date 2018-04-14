require 'rails_helper'

describe 'Admin' do
  describe 'visits indiviual order page' do
    it 'they see complete order information including user info' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      user = create(:user)
      order = user.orders.create!
      item = create(:item)
      order_item = order.order_items.create!(item_id: item.id, quantity: 3)

      visit order_path(order)

      expect(page).to have_content(order.created_at)
      expect(page).to have_content(order.user_fullname)
      expect(page).to have_content(order.user_address)
      expect(page).to have_content(item.title)
      expect(page).to have_content(order.total_quantity)
      expect(page).to have_content(order_item.quantity)
      expect(page).to have_content(order.item_subtotal(item))
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status)
    end
  end
end
