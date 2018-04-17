require 'rails_helper'

feature 'On the stations path' do
  context 'an Admin user' do
    scenario 'can edit a station from station/edit' do
      admin = create(:admin)
      stations = create_list(:station, 35)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path

      within 'tr:nth-child(31)' do
        click_on 'Edit'
      end

      fill_in 'station[name]', with: 'blah'
      fill_in 'station[dock_count]', with: 35
      fill_in 'station[city]', with: 'denver'
      fill_in 'station[installation_date]', with: "2013/08/01"

      click_on 'Update Station'

      expect(current_path).to eq(station_path('blah'))
      expect(page).to have_content('blah')
      expect(page).to have_content(35)
      expect(page).to have_content('denver')

      expect(page).to have_content("Station 30 was updated")
    end
  end
end
