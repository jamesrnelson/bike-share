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
end
