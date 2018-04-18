require 'rails_helper'

describe 'Admin' do
  context 'deletes condition from index' do
    scenario 'there is a flash message and that condition is gone' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      condition = create(:condition)
      visit conditions_path

      expect(page).to have_button('Delete')
      expect(page).to have_content(condition.max_temperature)
      expect(page).to have_content(condition.mean_temperature)

      click_on 'Delete'

      expect(page).to_not have_content(condition.max_temperature)
      expect(page).to_not have_content(condition.mean_temperature)
      expect(page).to have_content("You have successfully deleted the weather conditions for #{condition.date}.")
    end
  end
end
