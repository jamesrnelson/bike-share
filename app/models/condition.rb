class Condition < ApplicationRecord
  validates_presence_of :date,
                       :max_temperature,
                       :min_temperature,
                       :mean_temperature,
                       :mean_humidity,
                       :mean_visibility,
                       :mean_wind_speed,
                       :precipitation,
                       :zip_code

  def self.most_rides
    select('conditions.*, count(trips.id) AS trip_count')
    .joins('INNER JOIN trips ON conditions.date = trips.start_date')
    .group('conditions.id')
    .order('trip_count DESC')
    .first
  end

  def self.least_rides
    select('conditions.*, count(trips.id) AS trip_count')
    .joins('INNER JOIN trips ON conditions.date = trips.start_date')
    .group('conditions.id')
    .order('trip_count ASC')
    .first
  end
end
