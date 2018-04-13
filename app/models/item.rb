class Item < ApplicationRecord
  validates :description, :price, :status, :image, presence: true
  validates :title, presence: true, uniqueness: true
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :carts
  enum status: ['retired', 'active']
end
