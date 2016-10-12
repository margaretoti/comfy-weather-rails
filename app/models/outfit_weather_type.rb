class OutfitWeatherType < ActiveRecord::Base
  enum rating: { chilly: 0, comfy: 1, toasty: 2 }

  belongs_to :outfit
  belongs_to :weather_type

  validates :outfit, presence: true
  validates :weather_type, presence: true
end
