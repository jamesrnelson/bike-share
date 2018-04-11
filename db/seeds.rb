require 'csv'

CSV.foreach('./db/csv/station.csv', headers: true, header_converters: :symbol) do |row|
  Station.create!(id: row[:id], name: row[:name], dock_count: row[:dock_count], city: row[:city], installation_date: row[:installation_date])
end

CSV.foreach('./db/csv/truncated_data/trip.csv', headers: true, header_converters: :symbol) do |row|
  start_station = Station.find(row[:start_station_id])
  end_station = Station.find(row[:end_station_id])
  Trip.create(id: row[:id],
              duration: row[:duration],
              start_date: row[:start_date],
              start_station_id: start_station.id,
              end_date: row[:end_date],
              end_station_id: end_station.id,
              bike_id: row[:bike_id],
              subscription_type: row[:subscription_type],
              zip_code: row[:zip_code])
end

CSV.foreach('./db/csv/weather.csv', headers: true, header_converters: :symbol) do |row|
  Condition.create(date: row[:date],
                   max_temperature: row[:max_temperature_f],
                   mean_temperature: row[:mean_temperature_f],
                   min_temperature: row[:min_temperature_f],
                   mean_humidity: row[:mean_humidity],
                   mean_visibility: row[:mean_visibility_miles],
                   mean_wind_speed: row[:mean_wind_speed_mph],
                   precipitation: row[:precipitation_inches],
                   zip_code: row[:zip_code])
end
