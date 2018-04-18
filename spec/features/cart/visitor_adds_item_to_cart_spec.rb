require 'rails_helper'

describe 'As a visitor,' do
  describe 'When I visit /bike-shop,' do
    scenario 'I see at least 12 bike accessories (items) for sale,' do
      item1, item2, item3, item4 = create_list(:item, 4)

      visit bike_shop_path

      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item3.title)
      expect(page).to have_content(item4.title)
    end

    scenario 'When I click "Add to Cart", I see a flash message' do
      item = create(:item)

      visit bike_shop_path

      click_on 'Add to Cart'

      expect(current_path).to eq(bike_shop_path)
      expect(page).to have_content("You now have 1 #{item.title}")

      click_on 'Add to Cart'

      expect(page).to have_content("You now have 2 #{item.title}s")
    end

    scenario 'After adding items to the cart I see the count updated on all pages' do
      create(:item)

      visit bike_shop_path

      click_on 'Add to Cart'
      click_on 'Add to Cart'

      visit root_path

      expect(page).to have_content(2)
    end
  end
end
