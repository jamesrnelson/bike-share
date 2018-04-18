require 'rails_helper'

describe 'As a visitor,' do
  describe 'When I visit /cart,' do
    scenario 'I see items added to the cart with subtotal' do
      item1, item2 = create_list(:item, 2)
      total = '%.2f' % ((item1.price * 2) + item2.price)
      item1_subtotal = item1.price * 2

      visit bike_shop_path

      click_on item1.title
      click_on item1.title

      click_on item2.title

      visit cart_path

      expect(page).to have_content(item1.title)
      expect(page).to have_content(item1.price)
      expect(page).to have_content(item2.price)
      expect(page).to have_content(item1_subtotal)
      expect(page).to have_content(item2.title)
      expect(page).to have_content("Total: $#{total}")
    end

    scenario 'I can create an account and still see the same cart' do
      item1, item2 = create_list(:item, 2)
      total = '%.2f' % ((item1.price * 2) + item2.price)
      item1_subtotal = item1.price * 2

      visit bike_shop_path

      click_on item1.title
      click_on item1.title

      click_on item2.title

      visit new_user_path

      fill_in 'user[name]', with: 'Bob'
      fill_in 'user[username]', with: 'bobbyboy'
      fill_in 'user[password]', with: 'password'

<<<<<<< HEAD
      click_on "Create Account"
=======
      click_on 'Create User'
>>>>>>> 0ebe8db... Updates tests to add more consistency in style

      visit cart_path

      expect(page).to have_content(item1.title)
      expect(page).to have_content(item1.price)
      expect(page).to have_content(item2.price)
      expect(page).to have_content(item1_subtotal)
      expect(page).to have_content(item2.title)
      expect(page).to have_content("Total: $#{total}")

      click_on 'Logout'

      visit cart_path

      expect(page).to_not have_content(item1.title)
    end

    scenario 'I can create an account and checkout' do
      item1, item2 = create_list(:item, 2)
      total = '%.2f' % ((item1.price * 2) + item2.price)

      visit bike_shop_path

      click_on item1.title
      click_on item1.title

      click_on item2.title

      visit new_user_path

      fill_in 'user[name]', with: 'Bob'
      fill_in 'user[username]', with: 'bobbyboy'
      fill_in 'user[password]', with: 'password'

      click_on "Create Account"

      visit cart_path

      fill_in 'order[fullname]', with: 'Bob Hope'
      fill_in 'order[address]', with: "Bob Hope's Address"

      click_on 'Checkout'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content("Successfully submitted your order totaling $#{total}")
    end
  end
end
