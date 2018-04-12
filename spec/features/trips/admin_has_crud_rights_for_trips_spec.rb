require 'rails_helper'

feature 'On the trips path' do
  context 'an Admin user' do
    scenario 'can edit a trip from trip/edit' do
      admin = create(:admin)
      trips = create_list(:trip, 35)
      start_station = create(:station)
      end_station = create(:station)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_path

      within 'tr:nth-child(2)' do
        click_on 'Edit'
      end

      expect(current_path).to eq(edit_admin_trip_path(trips.first))
      fill_in 'trip[duration]', with: 10
      fill_in 'trip[start_date]', with: '2013-08-01'
      fill_in 'trip[end_date]', with: '2013-08-01'
      fill_in 'trip[bike_id]', with: 1
      fill_in 'trip[subscription_type]', with: 'Test'
      fill_in 'trip[zip_code]', with: 12345

      click_on 'Update Trip'

      expect(current_path).to eq(trip_path(trips.first))
      expect(page).to have_content('Test')
      expect(page).to have_content(10)
      expect(page).to have_content(12345)

      expect(page).to have_content("Trip #{trips.first.id} was updated")
    end
  end
end
