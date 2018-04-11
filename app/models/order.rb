class Order < ApplicationRecord
  validates :quantity, :order_num, presence: true
  belongs_to :user
  belongs_to :item

  enum status: ['ordered', 'completed', 'paid', 'cancelled']
end
