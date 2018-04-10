require 'rails_helper'

RSpec.describe Basket do

  describe "#total_count" do
    it "calculates the total number of items it holds" do
      subject = Basket.new({"1" => 2, "2" => 3})
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_item" do
    it "adds an item to its contents" do
      subject = Basket.new({"1" => 2, "2" => 3})
      subject.add_item(1)
      subject.add_item(2)

      expect(subject.contents).to eq({"1" => 3, "2" => 4})
    end
  end

  describe "#count_of" do
    it "reports how many of a particular item" do
      subject = Basket.new({"1" => 2, "2" => 3})
      subject.add_item(1)
      subject.add_item(2)

      expect(subject.count_of(1)).to eq(3)
      expect(subject.count_of(2)).to eq(4)
    end
  end
end
