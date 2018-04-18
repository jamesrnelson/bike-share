require 'rails_helper'

feature 'On the trips dashboard' do
  before(:each) do
    DatabaseCleaner.clean
    FactoryBot.reload
    @aug_trips = create_list(:trip, 5, start_date: '2013-08-29 10:11:00', end_date: '2013-08-31')
    @sep_trips = create_list(:trip, 15, start_date: '2013-09-15 10:11:00', end_date: '2013-09-17')
    @oct_trips = create_list(:trip, 10, start_date: '2013-10-02', end_date: '2013-10-04')
    @aug_condition = create(:condition, date: '2013-08-29')
    @sep_condition = create(:condition, date: '2013-09-15')
    @oct_condition = create(:condition, date: '2013-10-02')
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
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
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
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
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
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

    scenario 'can see most and least ridden bikes' do
      DatabaseCleaner.clean
      admin = create(:admin)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      create_list(:trip, 5, bike_id: 12345)
      create_list(:trip, 3, bike_id: 2)
      create_list(:trip, 1, bike_id: 98765)
      create(:condition)

      visit trips_dashboard_path

      expect(page).to have_content('Most Ridden Bike: 12345, 5 rides')
      expect(page).to have_content('Least Ridden Bike: 98765, 1 ride')
    end

    scenario 'can see a breakout of subscriptions' do
      DatabaseCleaner.clean
      create_list(:trip, 5, subscription_type: 'Subscriber')
      create_list(:trip, 1, subscription_type: 'Customer')
      create(:condition)

      visit trips_dashboard_path

      expect(page).to have_content('Rides by Subscription Type:')
      expect(page).to have_content('5 Subscribers')
      expect(page).to have_content('1 Customer')
    end

    scenario 'can see a date with most and least rides' do
      DatabaseCleaner.clean
      create_list(:trip, 4, start_date: '2013-01-03')
      create_list(:trip, 1, start_date: '2013-02-03')
      create_list(:trip, 10, start_date: '2014-02-04')
      create_list(:trip, 6, start_date: '2014-04-03')
      create(:condition, date: '2013-01-03')

      visit trips_dashboard_path

      expect(page).to have_content('Date with Most Rides: 2014-02-04, 10 rides')
      expect(page).to have_content('Date with Least Rides: 2013-02-03, 1 ride')
    end
  end
end
