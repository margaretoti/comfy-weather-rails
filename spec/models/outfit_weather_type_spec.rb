require 'rails_helper'

describe OutfitWeatherType do
  describe 'associations' do
    it { should belong_to(:outfit) }
    it { should belong_to(:weather_type) }
  end

  describe 'validationss' do
    it { should validate_presence_of(:outfit) }
    it { should validate_presence_of(:weather_type) }
    it { should validate_presence_of(:rating) }
  end
end
