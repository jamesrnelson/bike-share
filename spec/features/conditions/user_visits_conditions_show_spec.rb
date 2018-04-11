require 'rails_helper'

describe 'User visits conditions show' do
  context 'as a visitor' do
    scenario 'they see that condition attributes' do
      condition = create(:condition)

      visit condition_path(condition)

      expect(page).to have_content(condition.date)
      expect(page).to have_content(condition.max_temperature)
      expect(page).to have_content(condition.min_temperature)
      expect(page).to have_content(condition.mean_temperature)
      expect(page).to have_content(condition.mean_humidity)
      expect(page).to have_content(condition.mean_visibility)
      expect(page).to have_content(condition.mean_wind_speed)
      expect(page).to have_content(condition.precipitation)
      expect(page).to have_content(condition.zip_code)
    end
  end
end
