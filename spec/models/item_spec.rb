require "rails_helper"

describe Item, type: :model do
  describe "validations" do
    it "default status is 1 and image" do
      item = Item.new(title: 'a', description: 'b', price: 5.25)

      expect(item).to be_valid
      expect(item.status).to eq("Active")
      expect(item.image).to eq('img_default.jpg')
    end
  end

  describe "relationships" do
    it "has_many_orders" do
      item = create(:item)
      expect(item).to respond_to(:orders)
    end
    it "has many carts" do
      item = create(:item)
      expect(item).to respond_to(:carts)
    end
  end

  # describe 'statuses' do
  #   it

end
