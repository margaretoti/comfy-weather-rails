class WeatherType < ActiveRecord::Base
  enum precip_type: { rain: 0, snow: 1, sleet: 2 }

  has_many :outfit_weather_types
  has_many :outfits, through: :outfit_weather_types

  validates :temp_range, presence: true
end
