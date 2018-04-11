require 'rails_helper'

describe 'As a visitor,' do
  describe 'When I visit /bike-shop,' do
    scenario 'I see at least 12 bike accessories (items) for sale,' do
      Item.create!(title: 'one', description: 'blah', price: 5.0)
      Item.create!(title: 'two', description: 'blah', price: 5.0)
      Item.create!(title: 'three', description: 'blah', price: 5.0)
      Item.create!(title: 'four', description: 'blah', price: 5.0)
      Item.create!(title: 'five', description: 'blah', price: 5.0)
      Item.create!(title: 'six', description: 'blah', price: 5.0)
      Item.create!(title: 'seven', description: 'blah', price: 5.0)
      Item.create!(title: 'eight', description: 'blah', price: 5.0)
      Item.create!(title: 'nine', description: 'blah', price: 5.0)
      Item.create!(title: 'ten', description: 'blah', price: 5.0)
      Item.create!(title: 'eleven', description: 'blah', price: 5.0)
      Item.create!(title: 'twelve', description: 'blah', price: 5.0)

      visit bike_shop_path

      expect(page).to have_content('one')
      expect(page).to have_content('six')
      expect(page).to have_content('seven')
      expect(page).to have_content('twelve')
    end

    scenario 'When I click "Add to Cart", I see a flash message' do
      Item.create!(title: 'one', description: 'blah', price: 5.0)

      visit bike_shop_path

      click_on 'Add to Cart'

      expect(current_path).to eq(bike_shop_path)
      expect(page).to have_content('You now have 1 one')

      click_on 'Add to Cart'

      expect(page).to have_content('You now have 2 ones')


    end

    scenario 'After adding items to the cart I see the count updated on all pages' do
      Item.create!(title: 'one', description: 'blah', price: 5.0)

      visit bike_shop_path

      click_on 'Add to Cart'

      expect(current_path).to eq(bike_shop_path)
      expect(page).to have_content('You now have 1 one')

      click_on 'Add to Cart'

      expect(page).to have_content('You now have 2 ones')

      visit dashboard_path

      expect(page).to have_content('2')
    end
  end
end
