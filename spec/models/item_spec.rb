require "rails_helper"

describe Item, type: :model do
  describe "validations" do
    it "default status is 1 and image" do
      item = create(:item)

      expect(item).to be_valid
      expect(item.status).to eq("active")
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

  describe 'statuses' do
    it 'are created as active by default' do
      item = create(:item)

      expect(item.status).to eq('active')
      expect(item.active?).to be_truthy
    end

    it 'can be created as retired' do
      item = create(:item, status: 0)

      expect(item.status).to eq('retired')
      expect(item.retired?).to be_truthy
    end
  end

end
