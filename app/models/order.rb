class Order < ApplicationRecord
  validates_presence_of :fullname, :address
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  scope :status, -> (status) { where status: status }

  enum status: ['ordered', 'completed', 'paid', 'cancelled']

  def item_quantity(item)
    if order_items.find_by(item_id: item.id).quantity.nil?
      0
    else
      order_items.find_by(item_id: item.id).quantity
    end
  end

  def item_subtotal(item)
    item_quantity(item) * item.price
  end

  def total
    items.inject(0) { |sum, item| sum + item_subtotal(item) }
  end

  def total_quantity
    order_items.sum(:quantity)
  end

  def self.count_by_status(status)
    where("status = #{status}").length
  end
end
