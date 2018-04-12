require 'rails_helper'

feature 'User visits trip index' do
  context 'as a visitor' do
    it 'should see the first 30 trips and link to see more' do
      trips = create_list(:trip, 35)

      visit trips_path

      expect(page).to have_content(trips.first.duration)
      expect(page).to have_content(trips.first.start_date)
      expect(page).to have_content(trips.first.start_station.name)
      expect(page).to have_content(trips.first.end_date)
      expect(page).to have_content(trips.first.end_station.name)
      expect(page).to have_content(trips.first.bike_id)
      expect(page).to have_content(trips.first.subscription_type)
      expect(page).to have_content(trips.first.zip_code)

      expect(page).to have_content(trips[29].bike_id)
      expect(page).to_not have_content(trips[30].bike_id)

      expect(page).to_not have_content('Edit')
    end

    it 'clicking the page 2 button should display the next 30 trips' do
      trips = create_list(:trip, 61)

      visit trips_path
      click_link '2'

      expect(page).to_not have_content(trips[29].bike_id)
      expect(page).to_not have_content(trips[60].bike_id)
      expect(page).to have_content(trips[30].bike_id)
    end
  end

  context 'as an admin' do
    scenario 'should see the first 30 trips' do
      admin = create(:admin)
      trips = create_list(:trip, 35)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_path

      expect(page).to have_content(trips.first.duration)
      expect(page).to have_content(trips.first.start_date)
      expect(page).to have_content(trips.first.start_station.name)
      expect(page).to have_content(trips.first.end_date)
      expect(page).to have_content(trips.first.end_station.name)
      expect(page).to have_content(trips.first.bike_id)
      expect(page).to have_content(trips.first.subscription_type)
      expect(page).to have_content(trips.first.zip_code)

      expect(page).to have_content(trips[29].bike_id)
      expect(page).to_not have_content(trips[30].bike_id)
    end

    scenario 'should see buttons to edit and delete a trip' do
      admin = create(:admin)
      trips = create_list(:trip, 35)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_path

      within 'tr:nth-child(2)' do
        expect(page).to have_button 'Edit'
        expect(page).to have_button 'Delete'
      end

      within 'tr:last-child' do
        expect(page).to have_button 'Edit'
        expect(page).to have_button 'Delete'
      end
    end
  end
end
