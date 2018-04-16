# Defines Trip model
class Trip < ApplicationRecord
  validates :start_date, presence: true
  validates :start_station, presence: true
  validates :bike_id, presence: true
  validates :subscription_type, presence: true
  validates :zip_code, presence: true

  belongs_to :start_station, :class_name => 'Station'
  belongs_to :end_station, :class_name => 'Station'
  belongs_to :condition
end
