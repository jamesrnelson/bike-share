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

    it 'should build #duration_metrics' do
      expected = { longest: @longest_trip, average: 17.33, shortest: @shortest_trip }

      expect(Trip.duration_metrics).to eq(expected)
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

    it 'should build #rides_by_date summary' do
      DatabaseCleaner.clean
      create_list(:trip, 4, start_date: '2013-01-03')
      create_list(:trip, 2, start_date: '2013-02-03')
      create_list(:trip, 10, start_date: '2014-03-03')
      create_list(:trip, 6, start_date: '2014-04-03')

      expected = { years: { '2013' => 6, '2014' => 16 },
                   months: { ['2013 01', 'January 2013'] => 4,
                             ['2013 02', 'February 2013'] => 2,
                             ['2014 03', 'March 2014'] => 10,
                             ['2014 04', 'April 2014'] => 6 } }

      expect(Trip.rides_by_date).to eq(expected)
    end
  end
end
