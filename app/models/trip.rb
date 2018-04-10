# Defines Trip model
class Trip < ApplicationRecord
  validates :start_date, presence: true
  validates :start_station, presence: true
  validates :bike_id, presence: true
  validates :subscription_type, presence: true
  validates :zip_code, presence: true
end
