FactoryBot.define do
  factory :condition do
    date '2013-08-29'
    max_temperature { rand(75.0..90.0).round(1) }
    mean_temperature { rand(65.0..75.0).round(1) }
    min_temperature { rand(50.0..65.0).round(1) }
    mean_humidity { rand(65.0..75.0).round(1) }
    mean_visibility 10.0
    mean_wind_speed { rand(5.0..23.0).round(1) }
    precipitation { rand(0..2.5).round(2) }
    zip_code 941_07
  end

  factory :station do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:dock_count) { rand(0..100) }
    sequence(:city) { |n| "City #{n}" }
    installation_date '2015-02-03'
  end

  factory :trip do
    duration 1040
    start_date '2013-08-29 10:11:00'
    association :start_station, factory: :station
    end_date '2013-08-29 10:31:00'
    association :end_station, factory: :station
    sequence(:bike_id) { |n| 1000000 + n }
    subscription_type 'Subscriber'
    zip_code 94303
  end

  factory :user do
    sequence(:name) { "Name #{Random.rand(1000).to_s}" }
    sequence(:username) { "Username #{Random.rand(1000).to_s}" }
    sequence(:password) { |n| "Password #{n}" }
  end

  factory :admin, class: User do
    name "Admin"
    sequence(:username) { |n| "Username #{n}" }
    sequence(:password) { |n| "Password #{n}" }
    status 1
  end

  factory :item do
    sequence(:title) { |n| "Item #{n}" }
    sequence(:description) { |n| "Item #{n} Description" }
    sequence(:price) { rand(0..100) }
  end
end
