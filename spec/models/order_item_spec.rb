require 'rails_helper'

describe OrderItem, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:quantity) }
  end
  describe 'relationships' do
    it "belongs to item" do
      user = create(:user)
      order = user.orders.create!(user_id: 1, fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      item = create(:item)
      order_item = OrderItem.create!(order_id: order.id, item_id: item.id, quantity: 5)
      expect(order_item).to respond_to(:item)
    end
    it "belongs to order" do
      user = create(:user)
      order = user.orders.create!(user_id: 1, fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      item = create(:item)
      order_item = OrderItem.create!(order_id: order.id, item_id: item.id, quantity: 5)
      expect(order_item).to respond_to(:order)
    end
  end
end
