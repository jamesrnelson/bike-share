require 'csv'

CSV.foreach('./db/truncated_data/station.csv', headers: true, header_converters: :symbol) do |row|
  Station.create!(id: row[:id], name: row[:name], dock_count: row[:dock_count], city: row[:city], installation_date: row[:installation_date])
end

CSV.foreach('./db/truncated_data/trip.csv', headers: true, header_converters: :symbol) do |row|
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

CSV.foreach('./db/truncated_data/weather.csv', headers: true, header_converters: :symbol) do |row|
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

Item.create(title: 'Seat', description: 'Comphier than what you have now', price: 10.00)
Item.create(title: 'Peddles', description: 'You need em to ride', price: 15.95)
Item.create(title: 'Helmet', description: 'Protect yourself!', price: 12.95)
Item.create(title: 'Bell', description: 'JJJIING JJJIING', price: 3.5)
Item.create(title: 'Saddle-bags', description: 'Aerodynamic....', price: 14.5)
Item.create(title: 'Horn', description: 'Horns are louder than bells', price: 3.5)
Item.create(title: 'Bike Lock', description: 'Protect your bike!', price: 18.95)
Item.create(title: 'Sweet Rims', description: 'Cooler than what you have now', price: 22)
Item.create(title: 'Sand Tires', description: 'For the beach crawlin\'', price: 32.00)
Item.create(title: 'Basket', description: 'Bike with more stuff', price: 11.50)
Item.create(title: 'Reflectors', description: 'Don\'t get hit', price: 2.5)
Item.create(title: 'Jersey', description: 'Actually aerodynamic', price: 18)
Item.create(title: 'Water Bottle', description: 'Hydrate!', price: 4.5)
Item.create(title: 'Water Bottle Holder', description: 'Hold the hydration', price: 4.5)
Item.create(title: 'Helmet Mirror ', description: 'See those slower bikers back there', price: 11)
