require 'rails_helper'

feature 'On the trips path' do
  context 'an Admin user' do
    scenario 'can edit a trip from trip/edit' do
      admin = create(:admin)
      trips = create_list(:trip, 35)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_path
      
      expect(page).to have_content(trips.first.duration)

      within 'tr:nth-child(2)' do
        click_on 'Delete'
      end

      within 'tr:nth-child(2)' do
        expect(page).to_not have_content(trips.first.duration)
      end
    end
  end
end
