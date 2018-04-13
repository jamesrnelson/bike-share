require 'rails_helper'

describe 'As a visitor,' do
  describe 'When I visit /cart,' do
    scenario 'I can remove an item' do
      item1 = Item.create!(title: 'one', description: 'blah', price: 5.0)
      item2 = Item.create!(title: 'two', description: 'asdf', price: 20.0)

      visit bike_shop_path

      click_on "#{item1.title}"
      click_on "#{item1.title}"

      click_on "#{item2.title}"

      visit cart_path

      click_on "#{item1.id.to_s}"

      expect(current_path).to eq(cart_path)
      expect(page).to_not have_content('blah')
    end

    scenario 'I can change the quantity of an item' do
      item1 = Item.create!(title: 'one', description: 'blah', price: 5.0)
      item2 = Item.create!(title: 'two', description: 'asdf', price: 20.0)

      visit bike_shop_path

      click_on item1.title
      click_on item1.title

      click_on item2.title

      visit cart_path

    end
  end
end
