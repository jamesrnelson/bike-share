FactoryBot.define do
  factory :station do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:dock_count) { rand(0..100) }
    sequence(:city) { |n| "City #{n}" }
    installation_date '2/3/15'
  end
end
