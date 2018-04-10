require 'rails_helper'

describe Station, type: :model do
  describe 'validates' do
    it 'presence of name' do
      station = Station.new(dock_count: 20, city: 'San Jose', installation_date: 3/2/2015)

      expect(station).to_not be_valid
    end

    it 'presence of dock_count' do
      station = Station.new(name: 'Station1', city: 'San Jose', installation_date: 3/2/2015)

      expect(station).to_not be_valid
    end

    it 'presence of city' do
      station = Station.new(name: 'Station1', dock_count: 20, installation_date: 3/2/2015)

      expect(station).to_not be_valid
    end

    it 'presence of installation date' do
      station = Station.new(name: 'Station1', dock_count: 20, city: 'San Jose')

      expect(station).to_not be_valid
    end
  end
end
