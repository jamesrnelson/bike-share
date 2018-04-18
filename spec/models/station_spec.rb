require 'rails_helper'

describe Station, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:dock_count)}
    it { should validate_presence_of(:city)}
    it { should validate_presence_of(:installation_date)}
  end

  describe 'class methods' do
    it 'should find the station with the #most_starting_rides' do
      most_starting_station = create(:station)
      most_ending_station = create(:station)
      create_list(:trip, 25, start_station: most_starting_station)
      create_list(:trip, 15, end_station: most_ending_station)
      create_list(:trip, 10)

      expect(Station.most_starting_rides).to eq(most_starting_station)
    end

    it 'should find the station with the #most_ending_rides' do
      most_starting_station = create(:station)
      most_ending_station = create(:station)
      create_list(:trip, 25, start_station: most_starting_station)
      create_list(:trip, 15, end_station: most_ending_station)
      create_list(:trip, 10)
      
      expect(Station.most_ending_rides).to eq(most_ending_station)
    end
  end

  describe 'instance methods' do
    describe '.start_count' do
      it 'returns total count of all trips starting at station' do
        station1 = create(:station)
        station2 = create(:station)
        create_list(:trip, 3, start_station: station1, end_station: station2, start_date: '2013-08-29 10:11:00', zip_code: 12345, bike_id: 4)
        create_list(:trip, 2, start_station: station1, end_station: station2, start_date: '2013-08-30 10:11:00')
        create_list(:trip, 2, end_station: station1)

        expect(station1.start_count).to eq(5)
      end
    end
    describe '.end_count' do
      it 'returns total count of all trips ending at station' do
        station1 = create(:station)
        station2 = create(:station)
        create_list(:trip, 3, start_station: station1, end_station: station2, start_date: '2013-08-29 10:11:00', zip_code: 12345, bike_id: 4)
        create_list(:trip, 2, start_station: station1, end_station: station2, start_date: '2013-08-30 10:11:00')
        create_list(:trip, 2, end_station: station1)

        expect(station1.end_count).to eq(2)
      end
    end
    describe '.most_frequent_destination' do
      it 'returns station that is the most frequent end station' do
        station1 = create(:station)
        station2 = create(:station)
        create_list(:trip, 3, start_station: station1, end_station: station2, start_date: '2013-08-29 10:11:00', zip_code: 12345, bike_id: 4)
        create_list(:trip, 2, start_station: station1, end_station: station2, start_date: '2013-08-30 10:11:00')
        create_list(:trip, 2, end_station: station1)

        expect(station1.most_frequent_destination).to eq(station2)
      end
    end
    describe '.most_frequent_origin' do
      it 'returns station that is the most frequent start station' do
        station1 = create(:station)
        station2 = create(:station)
        create_list(:trip, 3, start_station: station1, end_station: station2, start_date: '2013-08-29 10:11:00', zip_code: 12345, bike_id: 4)
        create_list(:trip, 2, start_station: station1, end_station: station2, start_date: '2013-08-30 10:11:00')
        create_list(:trip, 2, end_station: station1)

        expect(station1.most_frequent_origin).to eq(station2)
      end
    end
    describe '.most_trips_date' do
      it 'returns date that had most trips originating from station' do
        station1 = create(:station)
        station2 = create(:station)
        trip1, trip2, trip3 = create_list(:trip, 3, start_station: station1, end_station: station2, start_date: '2013-08-29 10:11:00', zip_code: 12345, bike_id: 4)
        create_list(:trip, 2, start_station: station1, end_station: station2, start_date: '2013-08-30 10:11:00')
        create_list(:trip, 2, end_station: station1)

        expect(station1.most_trips_date).to eq(trip3.start_date)
      end
    end
    describe '.most_frequent_zip_code' do
      it 'returns most frequent zip code for users starting trips at station' do
        station1 = create(:station)
        station2 = create(:station)
        trip1, trip2, trip3 = create_list(:trip, 3, start_station: station1, end_station: station2, start_date: '2013-08-29 10:11:00', zip_code: 12345, bike_id: 4)
        create_list(:trip, 2, start_station: station1, end_station: station2, start_date: '2013-08-30 10:11:00')
        create_list(:trip, 2, end_station: station1)

        expect(station1.most_frequent_zip_code).to eq(trip3.zip_code)
      end
    end
    describe '.most_used_bike' do
      it 'returns most used bike from station' do
        station1 = create(:station)
        station2 = create(:station)
        trip1, trip2, trip3 = create_list(:trip, 3, start_station: station1, end_station: station2, start_date: '2013-08-29 10:11:00', zip_code: 12345, bike_id: 4)
        create_list(:trip, 2, start_station: station1, end_station: station2, start_date: '2013-08-30 10:11:00')
        create_list(:trip, 2, end_station: station1)

        expect(station1.most_used_bike).to eq(trip3.bike_id)
      end
    end
  end
end
