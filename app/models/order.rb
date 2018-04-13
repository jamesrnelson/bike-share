class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  enum status: ['ordered', 'completed', 'paid', 'cancelled']

  def total
    items.sum { |item| item.price }
  end

  def item_quantity(item)
    items.group(:item_id).count[item.id]
  end

  def item_subtotal(item)
    item_quantity(item) * item.price
  end
end
