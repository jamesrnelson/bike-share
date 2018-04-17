require 'rails_helper'

describe Condition do
  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:max_temperature) }
    it { should validate_presence_of(:min_temperature) }
    it { should validate_presence_of(:mean_temperature) }
    it { should validate_presence_of(:mean_humidity) }
    it { should validate_presence_of(:mean_visibility) }
    it { should validate_presence_of(:mean_wind_speed) }
    it { should validate_presence_of(:precipitation) }
    it { should validate_presence_of(:zip_code) }
  end

  describe 'class methods' do
    it 'should find the condition for the day with most rides' do
      aug_trips = create_list(:trip, 5, start_date: '2013-08-29 10:11:00')
      sep_trips = create_list(:trip, 15, start_date: '2013-09-15 10:11:00')
      oct_trips = create_list(:trip, 10, start_date: '2013-10-02')
      aug_condition = create(:condition, date: '2013-08-29')
      sep_condition = create(:condition, date: '2013-09-15')
      oct_condition = create(:condition, date: '2013-10-02')

      expect(Condition.most_rides).to eq(sep_condition)
    end

    it 'should find the condition for the day with least rides' do
      aug_trips = create_list(:trip, 5, start_date: '2013-08-29 10:11:00')
      sep_trips = create_list(:trip, 15, start_date: '2013-09-15 10:11:00')
      oct_trips = create_list(:trip, 10, start_date: '2013-10-02')
      aug_condition = create(:condition, date: '2013-08-29')
      sep_condition = create(:condition, date: '2013-09-15')
      oct_condition = create(:condition, date: '2013-10-02')

      expect(Condition.least_rides).to eq(aug_condition)
    end

    it 'should find the most rides for provided attribute' do
      trips = create_list(:trip, 5)
      trip2 = create(:trip, start_date: '2013-08-30')
      condition1 = create(:condition, max_temperature: 55, zip_code: 94107)
      condition2 = create(:condition, date: '2013-08-30', max_temperature: 55, zip_code: 94107)

      expect(Condition.max_rides(max_temperature: 50..60)).to eq(5)
    end

    it 'should find the least rides for provided attribute' do
      trips = create_list(:trip, 5)
      trip2 = create(:trip, start_date: '2013-08-30')
      condition1 = create(:condition, max_temperature: 55, zip_code: 94107)
      condition2 = create(:condition, date: '2013-08-30', max_temperature: 55, zip_code: 94107)

      expect(Condition.min_rides(max_temperature: 50..60)).to eq(1)
    end

    it 'should find the average rides for provided attribute' do
      trips = create_list(:trip, 5)
      trip2 = create(:trip, start_date: '2013-08-30')
      condition1 = create(:condition, max_temperature: 55, zip_code: 94107)
      condition2 = create(:condition, date: '2013-08-30', max_temperature: 55, zip_code: 94107)

      expect(Condition.average_rides(max_temperature: 50..60)).to eq(3)
    end
  end
end
