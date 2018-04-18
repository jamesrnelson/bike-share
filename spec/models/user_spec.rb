require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it 'is invalid without a username' do
      user = User.new(password: 'pass', name: 'name')

      expect(user).to be_invalid
    end

    it 'is invalid if username not unique' do
      User.create(username: 'user', password: 'pass', name: 'name')
      invalid_user = User.new(username: 'user', password: 'pass', name: 'name')

      expect(invalid_user).to_not be_valid
    end
  end

  describe 'relationships' do
    it 'has_many_orders' do
      user = create(:user)
      expect(user).to respond_to(:orders)
    end
    it 'has many carts' do
      user = create(:user)
      expect(user).to respond_to(:carts)
    end
  end

  describe 'statuses' do
    it 'can be an admin' do
      admin = User.create!(username: 'user', password: 'pass', status: 'admin', name: 'name')

      expect(admin.status).to eq('admin')
    end

    it 'can be a default user' do
      reg_user = User.create!(username: 'user', password: 'pass', name: 'name')

      expect(reg_user.status).to eq('default')
    end
  end
end
