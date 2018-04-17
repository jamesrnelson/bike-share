class Item < ApplicationRecord
  validates :title, :description, :price, :status, presence: true
  validates :title, presence: true, uniqueness: true
  has_attached_file :image, default_url: "img_default.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :carts
  enum status: ['retired', 'active']
end
