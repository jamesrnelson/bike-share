require 'rails_helper'

describe Trip, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:start_station) }
    it { should validate_presence_of(:bike_id) }
    it { should validate_presence_of(:subscription_type) }
    it { should validate_presence_of(:zip_code) }
  end
end
