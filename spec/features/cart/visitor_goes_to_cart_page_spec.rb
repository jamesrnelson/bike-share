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

    scenario 'I can create an account and still see the same cart' do
      item1 = Item.create!(title: 'one', description: 'blah', price: 5.0)
      item2 = Item.create!(title: 'two', description: 'asdf', price: 20.0)

      visit bike_shop_path

      click_on item1.title
      click_on item1.title

      click_on item2.title

      visit new_user_path

      fill_in "user[name]", with: "Bob"
      fill_in "user[username]", with: "bobbyboy"
      fill_in "user[password]", with: "password"

      click_on "Create User"

      visit cart_path

      expect(page).to have_content('one')
      expect(page).to have_content(5)
      expect(page).to have_content(2)
      expect(page).to have_content(10)
      expect(page).to have_content('two')
      expect(page).to have_content(20)
      expect(page).to have_content('Total: 30.0')

      save_and_open_page
      click_on "Logout"

      visit cart_path

      expect(page).to_not have_content('one')
    end
  end
end
