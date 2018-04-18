require 'rails_helper'

describe 'Visitor' do
  describe 'visits station index' do
    it 'they see a list of all stations and attributes' do
      station1, station2, station3 = create_list(:station, 3)

      visit stations_path

      expect(page).to have_content(station1.name)
      expect(page).to have_content(station2.name)
      expect(page).to have_content(station3.name)
      expect(page).to have_content(station1.city)
      expect(page).to have_content(station2.dock_count)
      expect(page).to have_content(station3.installation_date)
    end
  end
end
