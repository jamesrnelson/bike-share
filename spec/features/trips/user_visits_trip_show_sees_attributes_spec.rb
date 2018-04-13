require 'rails_helper'

describe 'User visits the trip show page' do
  context 'as a visitor' do
    it 'they should see all attributes for that trip' do
      trip = create(:trip)

      visit trip_path(trip)

      expect(page).to have_content(trip.duration)
      expect(page).to have_content(trip.start_date)
      expect(page).to have_content(trip.start_station.name)
      expect(page).to have_content(trip.end_date)
      expect(page).to have_content(trip.end_station.name)
      expect(page).to have_content(trip.bike_id)
      expect(page).to have_content(trip.subscription_type)
      expect(page).to have_content(trip.zip_code)
    end
  end

  context 'as an admin' do
    scenario 'they should see all attributes for that trip' do
      trip = create(:trip)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trip_path(trip)

      expect(page).to have_content(trip.duration)
      expect(page).to have_content(trip.start_date)
      expect(page).to have_content(trip.start_station.name)
      expect(page).to have_content(trip.end_date)
      expect(page).to have_content(trip.end_station.name)
      expect(page).to have_content(trip.bike_id)
      expect(page).to have_content(trip.subscription_type)
      expect(page).to have_content(trip.zip_code)
    end

    scenario 'they should see edit button that links to edit trip page' do
      trip = create(:trip)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trip_path(trip)

      expect(page).to have_button('Edit')

      click_on 'Edit'

      expect(current_path).to eq(edit_admin_trip_path(trip))
    end

    scenario 'they should see delete button that deletes the trip' do
      trips = create_list(:trip, 35)
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trip_path(trips.first)

      expect(page).to have_button('Delete')

      click_on 'Delete'

      expect(current_path).to eq(trips_path)
      within 'tr:nth-child(2) td:first-child' do
        expect(page).to_not have_content(trips.first.id)
      end
    end
  end
end
