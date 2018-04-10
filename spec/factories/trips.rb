FactoryBot.define do
  factory :trip do
    duration 1040
    start_date '2013-08-29 10:11:00'
    start_station 'University and Emerson'
    end_date '2013-08-29 10:31:00'
    end_station 'California Ave Caltrain Station'
    sequence(:bike_id) { |n| 1000000 + n }
    subscription_type 'Subscriber'
    zip_code 94303
  end
end
