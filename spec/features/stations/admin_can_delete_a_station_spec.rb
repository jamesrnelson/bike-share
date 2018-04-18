require 'rails_helper'

feature 'On the stations path' do
  context 'an Admin user' do
    scenario 'can edit a station from station/edit' do
      admin = create(:admin)
      stations = create_list(:station, 9)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path

      within "\##{stations[0].id}" do
        expect(page).to have_content(stations.first.name)
      end

      click_on "#{stations.first.id} delete"

      expect(page).to have_content('Station 1 was successfully deleted')

      within 'tr:nth-child(2) td:first-child' do
        expect(page).to_not have_content(stations.first.name)
      end
    end
  end
end
