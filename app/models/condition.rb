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

  def most_rides

  end

  def least_rides

  end
end
