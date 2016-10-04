require 'rails_helper'

describe WeatherType do
  describe 'validations' do
    it { should validate_presence_of(:temp_range) }
  end

  describe 'associations' do
    it { should have_many(:outfit_weather_types) }
    it { should have_many(:outfits).through(:outfit_weather_types) }
  end
end
