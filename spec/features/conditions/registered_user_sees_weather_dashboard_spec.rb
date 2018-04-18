require 'rails_helper'

describe 'User visits weather dashboard' do
  it 'should display ride analytics for temperature ranges' do
    trips = create_list(:trip, 5)
    trip2 = create(:trip, start_date: '2013-08-30')
    condition1 = create(:condition, max_temperature: 55, zip_code: 94107)
    condition2 = create(:condition, date: '2013-08-30', max_temperature: 55, zip_code: 94107)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit conditions_dashboard_path
    expect(page).to have_content('Highest Temperature in a day')
    expect(page).to have_content('50 to 60 degrees (F):')
    expect(page).to have_content('5')
    expect(page).to have_content('1')
    expect(page).to have_content('3')
  end
end
