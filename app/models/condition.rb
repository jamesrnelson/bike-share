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

  def self.most_rides(info_hash)
    select('conditions.*, count(trips.id) AS trip_count')
    .joins('INNER JOIN trips ON conditions.date = trips.start_date')
    .group('conditions.id')
    .where(info_hash).order('trip_count DESC')
    .first.trip_count
  end

  def self.least_rides(info_hash)
    select('conditions.*, count(trips.id) AS trip_count')
    .joins('INNER JOIN trips ON conditions.date = trips.start_date')
    .group('conditions.id')
    .where(info_hash)
    .order("trip_count ASC")
    .first.trip_count
  end

  def self.average_rides(info_hash)
    trips = joins('INNER JOIN trips ON conditions.date = trips.start_date')
            .group('trips.start_date')
            .where(info_hash)
            .count.values
    trips.sum.to_f / trips.length
  end
end
