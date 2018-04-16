# Defines Trip model
class Trip < ApplicationRecord
  validates :start_date, presence: true
  validates :start_station, presence: true
  validates :bike_id, presence: true
  validates :subscription_type, presence: true
  validates :zip_code, presence: true

  belongs_to :start_station, :class_name => 'Station'
  belongs_to :end_station, :class_name => 'Station'

  def self.average_rides(info_hash)
    select('trips.*, conditions.*').joins('INNER JOIN conditions ON trips.start_date = conditions.date').group('conditions.date').where(info_hash)
  end
  
  def self.average_duration
    (average(:duration).to_f / 60).round(2)
  end

  def self.longest_ride
    order(duration: :desc).first
  end

  def self.shortest_ride
    order(duration: :asc).first
  end

  def self.duration_metrics
    metrics = { longest: longest_ride,
                average: average_duration,
                shortest: shortest_ride }
    metrics
  end
end
