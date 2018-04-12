require 'rails_helper'

describe 'User visits trip index' do
  it 'should display first 30 trips and link to see more' do
    trips = create_list(:trip, 35)

    visit trips_path

    expect(page).to have_content(trips.first.duration)
    expect(page).to have_content(trips.first.start_date)
    expect(page).to have_content(trips.first.start_station.name)
    expect(page).to have_content(trips.first.end_date)
    expect(page).to have_content(trips.first.end_station.name)
    expect(page).to have_content(trips.first.bike_id)
    expect(page).to have_content(trips.first.subscription_type)
    expect(page).to have_content(trips.first.zip_code)

    expect(page).to have_content(trips[29].bike_id)
    expect(page).to_not have_content(trips[30].bike_id)
  end
end

describe 'User visits trip index clicks to see more' do
  it 'should display the next 30 trips' do
    trips = create_list(:trip, 61)

    visit trips_path
    click_link '2'

    expect(page).to_not have_content(trips[29].bike_id)
    expect(page).to_not have_content(trips[60].bike_id)
    expect(page).to have_content(trips[30].bike_id)
  end
end
