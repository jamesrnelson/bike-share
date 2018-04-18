require 'rails_helper'

describe 'As a visitor,' do
  describe 'When I visit /cart,' do
    it 'I can remove an item' do
      item1, item2 = create_list(:item, 2)

      visit bike_shop_path

      click_on item1.title
      click_on item1.title

      click_on item2.title

      visit cart_path

      click_on item1.id

      expect(current_path).to eq(cart_path)
      expect(page).to_not have_content("  #{item1.title}  ")
    end

    it 'I can change the quantity of an item' do
      item1, item2 = create_list(:item, 2)

      visit bike_shop_path

      click_on item1.title
      click_on item1.title

      click_on item2.title

      visit cart_path
    end
  end
end
