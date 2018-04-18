require 'rails_helper'

feature 'User' do
  context 'navigates to a page that doesn\'t exist' do
    scenario 'they see a 404 page' do
      visit new_admin_trip_path

      expect(current_path).to eq('/404')
    end
  end
end
