require 'rails_helper'

describe Order, type: :model do
  describe 'relationships' do
    it "has_many_items" do
      user = create(:user)
      order = user.orders.create!(user_id: 1)
      expect(order).to respond_to(:items)
    end
    it "belongs_to user" do
      user = create(:user)
      order = user.orders.create!(user_id: 1)
      expect(order).to respond_to(:user)
    end
  end

  describe 'instance methods' do
    it '.total' do
      user = create(:user)
      order = user.orders.create!(user_id: 1)
      order.items.create!(title: 'seat', description: 'for sitting on bike', price: 20.00)
      order.items.create!(title: 'peddles', description: 'for moving bike', price: 25.00)
      order.items.create!(title: 'chains', description: 'mechanical', price: 5.00)

      expect(order.total).to eq(50.00)
    end

    it '.item_quantity' do
      user = create(:user)
      order = user.orders.create!(user_id: 1)
      item = order.items.create!(title: 'seat', description: 'for sitting on bike', price: 20.00)
      order.items << item
      order.items << item

      expect(order.item_quantity(item)).to eq(3)
    end

    it '.item_subtotal' do
      user = create(:user)
      order = user.orders.create!(user_id: 1)
      item = order.items.create!(title: 'seat', description: 'for sitting on bike', price: 20.00)
      order.items << item
      order.items << item

      expect(order.item_subtotal(item)).to eq(60.00)
    end
  end
end
