require 'rails_helper'

describe 'Admin visits conditions index' do
  context 'clicks on create weather conditions' do
    it 'can fill in information and submit form' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit conditions_path

      click_on 'Create Weather Conditions'

      fill_in 'Date', with: '11/11/2011'
      fill_in 'Max temperature', with: 80
      fill_in 'Mean temperature', with: 70
      fill_in 'Min temperature', with: 60
      fill_in 'Mean visibility', with: 10
      fill_in 'Mean humidity', with: 14
      fill_in 'Mean wind speed', with: 10
      fill_in 'Precipitation', with: 2
      fill_in 'Zip code', with: 80230
      click_on 'Create Condition'
      expect(page).to have_content('You have created new weather conditions.')
    end
  end
end
