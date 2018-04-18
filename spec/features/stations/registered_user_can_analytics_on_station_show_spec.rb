require 'rails_helper'

describe 'Registered user' do
  describe 'visits station show page' do
    it 'they see analytics for the station' do
      station1 = create(:station)
      station2 = create(:station)
      create_list(:trip, 3, start_station: station1, end_station: station2, start_date: '2013-08-29 10:11:00', zip_code: 12345, bike_id: 4)
      create_list(:trip, 2, start_station: station1, end_station: station2, start_date: '2013-08-30 10:11:00')
      create_list(:trip, 2, end_station: station1)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit station_path(station1.slug)

      expect(page).to have_content("Number of rides started at this station: 5")
      expect(page).to have_content("Number of rides ended at this station: 2")
      expect(page).to have_content("Most frequent destination station: #{station2.name}")
      expect(page).to have_content("Most frequent origination station: #{station2.name}")
      expect(page).to have_content("Greatest number of trips started at this station on #{trip1.date}.")
      expect(page).to have_content("Most users have a zip code of #{trip1.zipcode} that start trips at this station.")
      expect(page).to have_content("Bike \##{trip1.bike_id} is the most frequently used bike at this station.")
    end
  end
end
