class WeatherType < ActiveRecord::Base
  has_many :outfit_weather_types
  has_many :outfits, through: :outfit_weather_types

  validates :temp_range, presence: true
end
