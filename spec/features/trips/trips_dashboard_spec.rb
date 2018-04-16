require 'rails_helper'

feature 'On the trips dashboard' do
  before(:each) do
    @aug_trips = create_list(:trip, 5, start_date: '2013-08-29 10:11:00')
    @sep_trips = create_list(:trip, 15, start_date: '2013-09-15 10:11:00')
    @oct_trips = create_list(:trip, 10, start_date: '2013-10-02')
    @aug_condition = create(:condition, date: '2013-08-29')
    @sep_condition = create(:condition, date: '2013-09-15')
    @oct_condition = create(:condition, date: '2013-10-02')
  end

  context 'an Admin user' do
    scenario 'can see the weather on highest and lowest ride days' do
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_dashboard_path

      within '.most-rides' do
        expect(page).to have_content("Weather on the day with the most rides:")
        expect(page).to have_content(@sep_condition.max_temperature)
        expect(page).to have_content(@sep_condition.precipitation)
        expect(page).to have_content(@sep_condition.zip_code)
      end

      within '.least-rides' do
        expect(page).to have_content("Weather on the day with the least rides:")
        expect(page).to have_content(@aug_condition.max_temperature)
        expect(page).to have_content(@aug_condition.precipitation)
        expect(page).to have_content(@aug_condition.zip_code)
      end
    end
  end
end
