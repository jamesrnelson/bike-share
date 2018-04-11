require 'rails_helper'

describe 'As a visitor,' do
  describe 'When I visit /cart,' do
    scenario 'I see items added to the cart with subtotal' do
      item1 = Item.create!(title: 'one', description: 'blah', price: 5.0)
      item2 = Item.create!(title: 'two', description: 'asdf', price: 20.0)

      visit bike_shop_path

      click_on item1.title
      click_on item1.title

      click_on item2.title

      visit cart_path

      expect(page).to have_content('one')
      expect(page).to have_content(5)
      expect(page).to have_content(2)
      expect(page).to have_content(10)
      expect(page).to have_content('two')
      expect(page).to have_content(20)
      expect(page).to have_content('Total: 30.0')

    end
  end
end
