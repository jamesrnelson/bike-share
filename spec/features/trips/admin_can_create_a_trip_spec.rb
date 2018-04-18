require 'rails_helper'

feature 'On the trips path' do
  context 'an Admin user' do
    scenario 'can create a new trip from admin/trip/new' do
      admin = create(:admin)
      trips = create_list(:trip, 35)
      start_station = create(:station)
      end_station = create(:station)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_path

      click_on 'Create Trip'

      expect(current_path).to eq(new_admin_trip_path)
      fill_in 'trip[duration]', with: 10
      fill_in 'trip[start_date]', with: '2013-08-01'
      fill_in 'trip[end_date]', with: '2013-08-01'
      fill_in 'trip[bike_id]', with: 1
      select('Customer', from: 'trip[subscription_type]')
      fill_in 'trip[zip_code]', with: 12345

      click_on 'Create Trip'

      expect(current_path).to eq(trip_path(Trip.last))
      expect(page).to have_content('Customer')
      expect(page).to have_content(10)
      expect(page).to have_content(12345)

      expect(page).to have_content("Trip #{Trip.last.id} was created")
    end
  end
end
