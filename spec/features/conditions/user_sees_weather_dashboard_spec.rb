require 'rails_helper'

describe 'User visits weather dashboard' do
  it 'should display ride analytics for temperature ranges' do
    trips = create_list(:trip, 5)
    trip2 = create(:trip, start_date: '2013-08-30')
    condition1 = create(:condition, max_temperature: 55)
    condition2 = create(:condition, date: '2013-08-30', max_temperature: 55)

    visit conditions_dashboard_path

    expect(page).to have_content('High Temperature Ranges')
    expect(page).to have_content('50-60')
    expect(page).to have_content('5')
    expect(page).to have_content('1')
    expect(page).to have_content('3')
  end
end
