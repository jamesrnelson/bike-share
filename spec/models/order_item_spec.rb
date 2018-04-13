require 'rails_helper'

describe OrderItem, type: :model do
  describe 'relationships' do
    it "belongs to item" do
      user = create(:user)
      order = user.orders.create!(user_id: 1)
      item = create(:item)
      order_item = OrderItem.create!(order_id: order.id, item_id: item.id)
      expect(order_item).to respond_to(:item)
    end
    it "belongs to order" do
      user = create(:user)
      order = user.orders.create!(user_id: 1)
      item = create(:item)
      order_item = OrderItem.create!(order_id: order.id, item_id: item.id)
      expect(order_item).to respond_to(:order)
    end
  end
end
