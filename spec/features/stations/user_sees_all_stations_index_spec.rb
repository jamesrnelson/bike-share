require 'rails_helper'

describe 'Visitor' do
  describe 'visits station index' do
    it 'they see a list of all stations and attributes' do
      factory_1, factory_2, factory_3 = create_list(:station, 3)

      visit stations_path

      expect(page).to have_content(factory_1.name)
      expect(page).to have_content(factory_2.name)
      expect(page).to have_content(factory_3.name)
      expect(page).to have_content(factory_1.city)
      expect(page).to have_content(factory_2.dock_count)
      expect(page).to have_content(factory_3.installation_date)
    end
  end
end
