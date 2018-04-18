require 'rails_helper'

describe 'Registered user' do
  describe 'visits station show page' do
    it 'they see analytics for the station' do
      station1 = create(:station)
      station2 = create(:station)
      trip1 = create(:trip, start_station_id: station1.id, end_station_id: station2.id, start_date: '2013-08-29 10:11:00', zip_code: 12345, bike_id: 4)
      create_list(:trip, 2, start_station_id: station1.id, end_station_id: station2.id, start_date: '2013-08-29 10:11:00', zip_code: 12345, bike_id: 4)
      create_list(:trip, 2, start_station_id: station1.id, end_station_id: station2.id, start_date: '2013-08-30 10:11:00')
      create_list(:trip, 2, start_station_id: station2.id, end_station_id: station1.id)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station1.slug)

      expect(page).to have_content("Number of rides started at this station: 5")
      expect(page).to have_content("Number of rides ended at this station: 2")
      expect(page).to have_content("Most frequent destination station: #{station2.name}")
      expect(page).to have_content("Most frequent origination station: #{station2.name}")
      expect(page).to have_content("Greatest number of trips started at this station on #{trip1.start_date}.")
      expect(page).to have_content("Most frequent user zip code: #{trip1.zip_code}")
      expect(page).to have_content("Most used bike at this station: Bike \##{trip1.bike_id}")
    end
  end
end
