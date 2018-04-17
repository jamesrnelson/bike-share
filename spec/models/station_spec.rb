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
end
