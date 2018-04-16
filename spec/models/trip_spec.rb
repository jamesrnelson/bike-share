require 'rails_helper'

describe Trip, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:start_station) }
    it { should validate_presence_of(:bike_id) }
    it { should validate_presence_of(:subscription_type) }
    it { should validate_presence_of(:zip_code) }
  end

  describe 'class methods' do
    before(:each) do
      @longest_trip = create(:trip, duration: 1060)
      @shortest_trip = create(:trip, duration: 1020)
      create(:trip, duration: 1040)
    end

    it 'should find the #average_duration' do
      expect(Trip.average_duration).to eq(17.33)
    end

    it 'should find the #longest_ride' do
      expect(Trip.longest_ride).to eq(@longest_trip)
    end

    it 'should find the #shortest_ride' do
      expect(Trip.shortest_ride).to eq(@shortest_trip)
    end
  end
end
