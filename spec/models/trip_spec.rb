require 'rails_helper'

describe Trip, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:start_station) }
    it { should validate_presence_of(:bike_id) }
    it { should validate_presence_of(:subscription_type) }
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

    it 'should find #rides_by_month' do
      DatabaseCleaner.clean
      create_list(:trip, 4, start_date: '2013-01-03')
      create_list(:trip, 2, start_date: '2013-02-03')
      create_list(:trip, 10, start_date: '2013-03-03')
      create_list(:trip, 6, start_date: '2013-04-03')

      expected = { ['2013 01', 'January 2013'] => 4,
                   ['2013 02', 'February 2013'] => 2,
                   ['2013 03', 'March 2013'] => 10,
                   ['2013 04', 'April 2013'] => 6 }

      expect(Trip.rides_by_month).to eq(expected)
    end

    it 'should subtotal #rides_by_year' do
      DatabaseCleaner.clean
      create_list(:trip, 4, start_date: '2013-01-03')
      create_list(:trip, 2, start_date: '2013-02-03')
      create_list(:trip, 10, start_date: '2014-01-03')
      create_list(:trip, 6, start_date: '2014-02-03')

      expected = { '2013' => 6, '2014' => 16 }

      expect(Trip.rides_by_year).to eq(expected)
    end

    it 'should find #most_ridden_bike' do
      DatabaseCleaner.clean
      create_list(:trip, 5, bike_id: 12345)
      create_list(:trip, 3, bike_id: 2)
      create_list(:trip, 1, bike_id: 98765)

      expect(Trip.most_ridden_bike).to eq([12345, 5])
    end

    it 'should find #least_ridden_bike' do
      DatabaseCleaner.clean
      create_list(:trip, 5, bike_id: 12345)
      create_list(:trip, 3, bike_id: 2)
      create_list(:trip, 1, bike_id: 98765)

      expect(Trip.least_ridden_bike).to eq([98765, 1])
    end

    it 'should build #subscription_metrics' do
      DatabaseCleaner.clean
      create_list(:trip, 5, subscription_type: 'Subscriber')
      create_list(:trip, 1, subscription_type: 'Customer')

      expected = { 'Subscriber' => 5, 'Customer' => 1 }

      expect(Trip.subscription_metrics).to eq(expected)
    end

    it 'should find #most_trips_date' do
      DatabaseCleaner.clean
      create_list(:trip, 4, start_date: '2013-01-03')
      create_list(:trip, 2, start_date: '2013-02-03')
      create_list(:trip, 10, start_date: '2014-02-04')
      create_list(:trip, 6, start_date: '2014-04-03')

      expected = ['2014-02-04', 10]

      expect(Trip.most_trips_date).to eq(expected)
    end

    it 'should find #least_trips_date' do
      DatabaseCleaner.clean
      create_list(:trip, 4, start_date: '2013-01-03')
      create_list(:trip, 2, start_date: '2013-02-03')
      create_list(:trip, 10, start_date: '2014-02-04')
      create_list(:trip, 6, start_date: '2014-04-03')

      expected =  ['2013-02-03', 2]

      expect(Trip.least_trips_date).to eq(expected)
    end
  end
end
