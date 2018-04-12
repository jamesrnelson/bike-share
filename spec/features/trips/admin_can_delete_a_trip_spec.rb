require 'rails_helper'

feature 'On the trips path' do
  context 'an Admin user' do
    scenario 'can edit a trip from trip/edit' do
      admin = create(:admin)
      trips = create_list(:trip, 35)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_path


      within 'tr:nth-child(2) td:first-child' do
        expect(page).to have_content(trips.first.id)
      end

      click_on "#{trips.first.id} delete"

      expect(page).to have_content('Trip 1 was successfully deleted')

      within 'tr:nth-child(2) td:first-child' do
        expect(page).to_not have_content(trips.first.id)
      end
    end
  end
end
