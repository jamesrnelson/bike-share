require 'csv'

CSV.foreach('./db/truncated_data/station.csv', headers: true, header_converters: :symbol) do |row|
  Station.create!(id: row[:id], name: row[:name], dock_count: row[:dock_count], city: row[:city], installation_date: DateTime.strptime(row[:installation_date], "%m/%d/%Y"))
end

CSV.foreach('./db/truncated_data/trip.csv', headers: true, header_converters: :symbol) do |row|
  start_station = Station.find(row[:start_station_id])
  end_station = Station.find(row[:end_station_id])
  Trip.create(id: row[:id],
              duration: row[:duration],
              start_date: DateTime.strptime(row[:start_date], "%m/%d/%Y %H:%M"),
              start_station_id: start_station.id,
              end_date: DateTime.strptime(row[:end_date], "%m/%d/%Y %H:%M"),
              end_station_id: end_station.id,
              bike_id: row[:bike_id],
              subscription_type: row[:subscription_type],
              zip_code: row[:zip_code])
end

CSV.foreach('./db/truncated_data/weather.csv', headers: true, header_converters: :symbol) do |row|
  Condition.create(date: DateTime.strptime(row[:date], "%m/%d/%Y"),
                   max_temperature: row[:max_temperature_f],
                   mean_temperature: row[:mean_temperature_f],
                   min_temperature: row[:min_temperature_f],
                   mean_humidity: row[:mean_humidity],
                   mean_visibility: row[:mean_visibility_miles],
                   mean_wind_speed: row[:mean_wind_speed_mph],
                   precipitation: row[:precipitation_inches],
                   zip_code: row[:zip_code])
end

Item.create(title: 'Seat', description: 'Comphier than what you have now', price: 10.00, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Peddles', description: 'You need em to ride', price: 15.95, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Helmet', description: 'Protect yourself!', price: 12.95, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Bell', description: 'JJJIING JJJIING', price: 3.5, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Saddle-bags', description: 'Aerodynamic....', price: 14.5, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Horn', description: 'Horns are louder than bells', price: 3.5, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Bike Lock', description: 'Protect your bike!', price: 18.95, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Sweet Rims', description: 'Cooler than what you have now', price: 22, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Sand Tires', description: 'For the beach crawlin\'', price: 32.00, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Basket', description: 'Bike with more stuff', price: 11.50, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Reflectors', description: 'Don\'t get hit', price: 2.5, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Jersey', description: 'Actually aerodynamic', price: 18, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Water Bottle', description: 'Hydrate!', price: 4.5, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Water Bottle Holder', description: 'Hold the hydration', price: 4.5, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
Item.create(title: 'Helmet Mirror ', description: 'See those slower bikers back there', price: 11, image: File.new(Rails.root.join('app/assets/images/img_default.jpg')))
