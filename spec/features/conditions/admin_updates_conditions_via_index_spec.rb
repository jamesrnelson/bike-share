require 'rails_helper'

describe 'Admin' do
  context 'visits conditions index' do
    scenario 'they see all conditions and edit button' do
      admin = User.create!(
        name: 'Jimmy',
        username: 'Jimmy',
        password: 'test',
        status: 'admin'
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      conditions = create_list(:condition, 10)
      visit admin_conditions_path
      expect(page).to have_content(conditions[0].date)
      expect(page).to have_content(conditions[1].max_temperature)
      expect(page).to have_content(conditions[2].mean_temperature)
      expect(page).to have_content(conditions[3].min_temperature)
      expect(page).to have_content(conditions[4].mean_humidity)
      expect(page).to have_content(conditions[6].mean_visibility)
      expect(page).to have_content(conditions[7].mean_wind_speed)
      expect(page).to have_content(conditions[9].precipitation)

      expect(page).to have_link('Edit')
    end
  end

  context 'clicks on edit link' do
    scenario 'they fill in information and submit' do
      admin = User.create!(
        name: 'Jimmy',
        username: 'Jimmy',
        password: 'test',
        status: 'admin'
      )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      condition = create(:condition)
      visit admin_conditions_path

      click_on 'Edit'

      fill_in 'Date', with: '11/11/2011'
      fill_in 'Max temperature', with: 80
      fill_in 'Mean temperature', with: 70
      fill_in 'Min temperature', with: 60
      fill_in 'Mean visibility', with: 10
      fill_in 'Mean wind speed', with: 10
      fill_in 'Precipitation', with: 2
      click_on 'Update Conditions'

      expect(current_path).to eq(admin_condition_path(condition))
      expect(page).to have_content('You have updated the weather conditions.')
      expect(page).to have_content('80')
      expect(page).to have_content('70')
      expect(page).to have_content('60')
      expect(page).to have_content('10')
      expect(page).to have_content('2')
    end
  end
end
