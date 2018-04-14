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
end
