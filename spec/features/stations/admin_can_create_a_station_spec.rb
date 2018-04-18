require 'rails_helper'

feature 'On the stations path' do
  context 'an Admin user' do
    scenario 'can create a new station from admin/station/new' do
      admin = create(:admin)
      create_list(:station, 35)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit stations_path

      click_on 'Create Station'

      expect(current_path).to eq(new_admin_station_path)
      fill_in 'station[name]', with: 'blah'
      fill_in 'station[dock_count]', with: 35
      fill_in 'station[city]', with: 'denver'
      fill_in 'station[installation_date]', with: "2013/08/01"

      click_on 'Create Station'

      expect(current_path).to eq(station_path(Station.last.slug))
      expect(page).to have_content('blah')
      expect(page).to have_content(35)
      expect(page).to have_content('denver')

      expect(page).to have_content("Station #{Station.last.id} was created")
    end
  end
end
