require 'rails_helper'

describe 'Admin' do
  describe 'visits admin dashboard' do
    it 'they see a list of all orders and total number of each order status' do
      user = create(:user)
      order1 = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      order2 = user.orders.create!(fullname: 'Peter Smith', address: '400 Spencer St., Longmont, CO 80501', status: 1)
      order3 = user.orders.create!(fullname: 'Bob Ross', address: '1000 Colors St., Magical Land, CO 1000', status: 2)
      order4 = user.orders.create!(fullname: 'Another Name', address: '600 Colors St., Magical Land, CO 1000', status: 3)

      admin = create(:admin)

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)
      fill_in 'name', with: admin.name
      fill_in 'username', with: admin.username
      fill_in 'password', with: admin.password

      within('.form') do
        click_on 'Login'
      end

      visit admin_dashboard_path

      expect(page).to have_content(order1.fullname)
      expect(page).to have_content(order2.fullname)
      expect(page).to have_content(order3.fullname)
      expect(page).to have_content(order4.fullname)
      expect(page).to have_content('Total Ordered: 1')
      expect(page).to have_content('Total Completed: 1')
      expect(page).to have_content('Total Paid: 1')
      expect(page).to have_content('Total Cancelled: 1')
    end

    it 'they can filter results based on order status' do
      user = create(:user)
      order1 = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      order2 = user.orders.create!(fullname: 'Peter Smith', address: '400 Spencer St., Longmont, CO 80501', status: 1)
      order3 = user.orders.create!(fullname: 'Bob Ross', address: '1000 Colors St., Magical Land, CO 1000', status: 2)
      order4 = user.orders.create!(fullname: 'Another Name', address: '600 Colors St., Magical Land, CO 1000', status: 3)

      admin = create(:admin)

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)
      fill_in 'name', with: admin.name
      fill_in 'username', with: admin.username
      fill_in 'password', with: admin.password

      within('.form') do
        click_on 'Login'
      end

      visit admin_dashboard_path

      click_on 'Total Ordered: 1'
      expect(page).to have_content(order1.fullname)
      expect(page).to_not have_content(order2.fullname)

      click_on 'Total Completed: 1'
      expect(page).to have_content(order2.fullname)
      expect(page).to_not have_content(order1.fullname)

      click_on 'Total Paid: 1'
      expect(page).to have_content(order3.fullname)
      expect(page).to_not have_content(order2.fullname)

      click_on 'Total Cancelled: 1'
      expect(page).to have_content(order4.fullname)
      expect(page).to_not have_content(order2.fullname)
    end

    it 'they see cancel and mark as paid links' do
      user = create(:user)
      order1 = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      order2 = user.orders.create!(fullname: 'Peter Smith', address: '400 Spencer St., Longmont, CO 80501', status: 1)
      order3 = user.orders.create!(fullname: 'Bob Ross', address: '1000 Colors St., Magical Land, CO 1000', status: 2)
      order4 = user.orders.create!(fullname: 'Another Name', address: '600 Colors St., Magical Land, CO 1000', status: 3)

      admin = create(:admin)

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)
      fill_in 'name', with: admin.name
      fill_in 'username', with: admin.username
      fill_in 'password', with: admin.password

      within('.form') do
        click_on 'Login'
      end

      visit admin_dashboard_path

      expect(page).to have_link("Cancel Order \##{order1.id}")
      expect(page).to have_link("Cancel Order \##{order1.id}")
      expect(page).to_not have_link("Cancel Order \##{order4.id}")

      expect(page).to have_link("Mark Order \##{order1.id} as Paid")
      expect(page).to_not have_link("Mark Order \##{order2.id} as Paid")
      expect(page).to_not have_link("Mark Order \##{order4.id} as Paid")
    end

    it 'they can cancel orders or mark orders as paid' do
      user = create(:user)
      order1 = user.orders.create!(fullname: 'Haley Mesander', address: '936 Spencer St., Longmont, CO 80501')
      order2 = user.orders.create!(fullname: 'Peter Smith', address: '400 Spencer St., Longmont, CO 80501')

      admin = create(:admin)

      visit root_path

      click_on 'Login'

      expect(current_path).to eq(login_path)
      fill_in 'name', with: admin.name
      fill_in 'username', with: admin.username
      fill_in 'password', with: admin.password

      within('.form') do
        click_on 'Login'
      end

      visit admin_dashboard_path

      click_on "Cancel Order \##{order1.id}"

      expect(page).to have_content('cancelled')

      click_on "Mark Order \##{order2.id} as Paid"

      expect(page).to have_content('paid')
    end
  end
end
