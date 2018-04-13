require 'rails_helper'

describe 'Registered user' do
  describe 'visits dashboard and clicks on an order link' do
    it 'they see all order information' do
      user = create(:user)
      order = user.orders.create!
      item1 = order.items.create!(title: 'seat', description: 'for sitting on bike', price: 20.00)
      item2 = order.items.create!(title: 'peddles', description: 'for moving bike', price: 25.00)
      item3 = order.items.create!(title: 'chains', description: 'mechanical', price: 5.00)
      order.items << item1

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_on "Order \##{order.id}"

      expect(current_path).to eq(order_path(order))
      expect(page).to have_content(order.status)
      expect(page).to have_content(order.created_at)
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item3.title)
      expect(page).to have_content('$70.00')
    end
  end
end
