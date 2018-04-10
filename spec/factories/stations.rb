FactoryBot.define do
  factory :station do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:dock_count) { rand(0..100) }
    sequence(:city) { |n| "City #{n}" }
    sequence(:installation_date) { "#{rand(1..12)}/#{rand(0..31)}/#{rand(2000..2017)}" }
  end
end
