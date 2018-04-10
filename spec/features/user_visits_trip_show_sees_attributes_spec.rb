require 'rails_helper'

describe 'User visits trip show page' do
  it 'should see all attributes for that trip' do
    trip = create(:trip)

    visit trip_path(trip)

    expect(page).to have_content(trip.duration)
    expect(page).to have_content(trip.start_date)
    expect(page).to have_content(trip.start_station)
    expect(page).to have_content(trip.end_date)
    expect(page).to have_content(trip.end_station)
    expect(page).to have_content(trip.bike_id)
    expect(page).to have_content(trip.subscription_type)
    expect(page).to have_content(trip.zip_code)
  end
end
