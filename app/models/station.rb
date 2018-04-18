class Station < ApplicationRecord
  validates_presence_of :name, :dock_count, :city, :installation_date
  before_save :generate_slug
  has_many :start_trips, class_name: "Trip", foreign_key: "start_station_id"
  has_many :end_trips, class_name: "Trip", foreign_key: "end_station_id"

  def generate_slug
    self.slug = name.parameterize
  end

  def self.alphabetize
    order(:name)
  end

  def self.total
    count
  end

  def self.avg_bikes
    average(:dock_count).round
  end

  def self.most_bikes
    most = maximum(:dock_count)
    where(dock_count: most)
  end

  def self.fewest_bikes
    fewest = minimum(:dock_count)
    where(dock_count: fewest)
  end

  def self.newest
    order(installation_date: :desc).first
  end

  def self.oldest
    order(:installation_date).first
  end

  def self.most_starting_rides
    select('stations.*, count(trips.id) AS trip_count')
    .joins('INNER JOIN trips ON stations.id = trips.start_station_id')
    .group('stations.id')
    .order('trip_count DESC')
    .first
  end

  def self.most_ending_rides
    select('stations.*, count(trips.id) AS trip_count')
    .joins('INNER JOIN trips ON stations.id = trips.end_station_id')
    .group('stations.id')
    .order('trip_count DESC')
    .first

  def start_count
    start_trips.count
  end

  def end_count
    end_trips.count
  end

  def most_frequent_destination
    start_trips
    .select('end_station_id, COUNT(end_station_id) AS count')
    .group(:end_station_id)
    .order('count DESC')
    .first
    .end_station
  end

  def most_frequent_origin
    end_trips
    .select('start_station_id, COUNT(start_station_id) AS count')
    .group(:start_station_id)
    .order('count DESC')
    .first
    .start_station
  end

  def most_trips_date
    start_trips
    .select('start_date AS date, count(start_date) AS count')
    .group('date')
    .to_a
    .first
    .date
  end

  def most_frequent_zip_code
    start_trips
    .select('zip_code, count(zip_code) AS count')
    .group(:zip_code)
    .to_a
    .first
    .zip_code
  end

  def most_used_bike
    start_trips
    .select('bike_id, count(bike_id) AS count')
    .group(:bike_id)
    .to_a
    .first
    .bike_id
  end
end
