require 'rails_helper'

describe 'Visitor' do
  describe 'visits individual station page' do
    it 'they see attributes for specific station' do
      station = create(:station)

      visit station_path(station.slug)

      expect(current_path).to eq("/stations/#{station.slug}")

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
    end
  end
end
