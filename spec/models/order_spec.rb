require 'rails_helper'

describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:fullname) }
    it { should validate_presence_of(:address) }
  end
  describe 'relationships' do
    it "has_many_items" do
      user = create(:user)
      order = user.orders.create!(user_id: 1, fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      expect(order).to respond_to(:items)
    end
    it "belongs_to user" do
      user = create(:user)
      order = user.orders.create!(user_id: 1, fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      expect(order).to respond_to(:user)
    end
  end

  describe 'instance methods' do
    it '.item_subtotal(item)' do
      user = create(:user)
      order = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      item = create(:item)
      order_item = order.order_items.create!(item_id: item.id, quantity: 3)

      expect(order.item_subtotal(item)).to eq(item.price * order_item.quantity)
    end
    it '.item_quantity(item)' do
      user = create(:user)
      order = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      item = create(:item)
      order_item = order.order_items.create!(item_id: item.id, quantity: 3)

      expect(order.item_quantity(item)).to eq(order_item.quantity)
    end
    it '.total' do
      user = create(:user)
      order = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      item1, item2 = create_list(:item, 3)
      order_item1 = order.order_items.create!(item_id: item1.id, quantity: 3)
      order_item2 = order.order_items.create!(item_id: item2.id, quantity: 1)
      total = (item1.price * order_item1.quantity) + (item2.price * order_item2.quantity)

      expect(order.total).to eq(total)
    end
    it '.total_quantity' do
      user = create(:user)
      order = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      item1, item2 = create_list(:item, 3)
      order_item1 = order.order_items.create!(item_id: item1.id, quantity: 3)
      order_item2 = order.order_items.create!(item_id: item2.id, quantity: 1)
      total_quantity = order_item1.quantity + order_item2.quantity

      expect(order.total_quantity).to eq(total_quantity)
    end
  end
end
