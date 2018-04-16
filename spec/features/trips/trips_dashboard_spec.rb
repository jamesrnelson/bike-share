require 'rails_helper'

feature 'On the trips dashboard' do
  before(:each) do
    @aug_trips = create_list(:trip, 5, start_date: '2013-08-29 10:11:00', end_date: '2013-08-31')
    @sep_trips = create_list(:trip, 15, start_date: '2013-09-15 10:11:00', end_date: '2013-09-17')
    @oct_trips = create_list(:trip, 10, start_date: '2013-10-02', end_date: '2013-10-04')
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

    scenario 'can see the average, longest, and shortest rides' do
      longest_trip = create(:trip, duration: 1060)
      shortest_trip = create(:trip, duration: 1020)
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_dashboard_path

      expect(page).to have_content('Average Ride Duration: 17.33 minutes')
      expect(page).to have_content("Longest Ride: #{longest_trip.id}")
      expect(page).to have_content("Shortest Ride: #{shortest_trip.id}")
    end

    scenario 'can see the station with the most starting and ending rides' do
      most_starting_station = create(:station)
      most_ending_station = create(:station)
      create_list(:trip, 25, start_station: most_starting_station)
      create_list(:trip, 15, end_station: most_ending_station)
      create_list(:trip, 10)

      visit trips_dashboard_path

      expect(page).to have_content("Most Starting Rides: #{most_starting_station.name}")
      expect(page).to have_content("Most Ending Rides: #{most_ending_station.name}")
    end

    scenario 'can see a summary of rides by date' do
      DatabaseCleaner.clean
      create_list(:trip, 4, start_date: '2013-01-03')
      create_list(:trip, 2, start_date: '2013-02-03')
      create_list(:trip, 10, start_date: '2014-03-03')
      create_list(:trip, 6, start_date: '2014-04-03')
      create(:condition, date: '2013-02-03')
      create(:condition, date: '2014-03-03')

      visit trips_dashboard_path

      within '.rides-by-month tr:nth-child(2)' do
        within 'td:first-child' do
          expect(page).to have_content('January 2013')
        end
        within 'td:nth-child(2)' do
          expect(page).to have_content('4')
        end
      end

      within '.rides-by-month tr:nth-child(4)' do
        within 'td:first-child' do
          expect(page).to have_content('March 2014')
        end
        within 'td:nth-child(2)' do
          expect(page).to have_content('10')
        end
      end

      within '.rides-by-year tr:nth-child(2)' do
        within 'td:first-child' do
          expect(page).to have_content('2013')
        end
        within 'td:nth-child(2)' do
          expect(page).to have_content('6')
        end
      end
    end
  end
end
