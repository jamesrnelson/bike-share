require 'rails_helper'

describe 'Visitor' do
  describe 'visits station index' do
    it 'they see a list of all stations and attributes' do
      station_1, station_2, station_3 = create_list(:station, 3)

      visit stations_path

      expect(page).to have_content(station_1.name)
      expect(page).to have_content(station_2.name)
      expect(page).to have_content(station_3.name)
      expect(page).to have_content(station_1.city)
      expect(page).to have_content(station_2.dock_count)
      expect(page).to have_content(station_3.installation_date)
    end
  end
end
