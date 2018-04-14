class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['ordered', 'completed', 'paid', 'cancelled']

  def item_quantity(item)
    order_items.find_by(item_id: item.id).quantity
  end

  def item_subtotal(item)
    item_quantity(item) * item.price
  end

  def total
    items.inject(0) { |sum, item| sum + item_subtotal(item) }
  end
end
