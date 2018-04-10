class Item < ApplicationRecord
  validates :description, :price, :status, :image, presence: true
  validates :title, presence: true, uniqueness: true
  has_many :orders
  has_many :carts
  enum status: ['Retired', 'Active']
end
