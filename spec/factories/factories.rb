FactoryBot.define do
  factory :condition do
    date '8/29/2013'
    max_temperature { rand(75.0..90.0).round(1) }
    mean_temperature { rand(65.0..75.0).round(1) }
    min_temperature { rand(50.0..65.0).round(1) }
    mean_humidity { rand(65.0..75.0).round(1) }
    mean_visibility 10.0
    mean_wind_speed { rand(5.0..23.0).round(1) }
    precipitation { rand(0..2.5).round(2) }
    zip_code 941_07
  end
end