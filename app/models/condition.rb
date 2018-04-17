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

  def self.max_rides(info_hash)
    trips = joins('INNER JOIN trips ON conditions.date = trips.start_date')
            .group('trips.start_date')
            .where(info_hash)
            .count.values
    if trips.max.nil?
      'There were no rides in zip code 94107 for this range.'
    else
      trips.max
    end
  end

  def self.min_rides(info_hash)
    trips = joins('INNER JOIN trips ON conditions.date = trips.start_date')
            .group('trips.start_date')
            .where(info_hash)
            .count.values
    if trips.min.nil?
      'There were no rides in zip code 94107 for this range.'
    else
      trips.min
    end
  end

  def self.average_rides(info_hash)
    trips = joins('INNER JOIN trips ON conditions.date = trips.start_date')
            .group('trips.start_date')
            .where(info_hash)
            .count.values
    average = (trips.sum.to_f / trips.length)
    if average.nan?
      'There were no rides in zip code 94107 for this range.'
    else
      average.round(1)
    end
  end
end
