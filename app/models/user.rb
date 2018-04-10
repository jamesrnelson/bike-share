class User < ApplicationRecord
  validates :name, :password, presence: true
  validates :username, presence: true, uniqueness: true
  has_secure_password
  has_many :carts, dependent: :destroy
  has_many :orders
  enum status: ['default', 'mod', 'super', 'admin']
end
