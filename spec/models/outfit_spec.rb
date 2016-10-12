require 'rails_helper'

describe Outfit do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
    it { should validate_length_of(:notes).is_at_most(250) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:outfit_article_of_clothings) }
    it { should have_many(:article_of_clothings).through(:outfit_article_of_clothings) }
    it { should have_many(:outfit_weather_types) }
    it { should have_many(:weather_types).through(:outfit_weather_types) }
  end

  describe 'Get a weather type upon creation' do
    it 'returns the correct weather_type that weather falls into' do
      stub_weather_api_request
      weather_type = create(:weather_type)
      outfit = create(:outfit)
      outfit.add_weather_type

      expect(outfit.weather_types.first).to eq(weather_type)
    end

    it 'will not add a weather type if the weather falls out of range' do
      stub_weather_api_request
      weather_type = create(:weather_type, :underflow)
      outfit = create(:outfit)

      expect(outfit.weather_types).to be_empty
    end
  end
end
