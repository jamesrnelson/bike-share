require 'rails_helper'

describe 'Registered user' do
  describe 'visits dashboard' do
    it 'they see a list of orders' do
      user = create(:user)
      order1 = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      order2 = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      order3 = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content("Order \##{order1.id}")
      expect(page).to have_content("Order \##{order2.id}")
      expect(page).to have_content("Order \##{order3.id}")
    end
  end
end
