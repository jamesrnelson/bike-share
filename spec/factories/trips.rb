FactoryBot.define do
  factory :trip do
    duration 1040
    start_date '8/29/2013 10:11'
    start_station 'University and Emerson'
    end_date '8/29/2013 10:31'
    end_station 'California Ave Caltrain Station'
    bike_id 13
    subscription_type 'Subscriber'
    zip_code 94303
  end
end
