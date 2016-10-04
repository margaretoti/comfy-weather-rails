class OutfitWeatherType < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :weather_type

  validates :outfit, presence: true
  validates :weather_type, presence: true 
  validates :rating, presence: true
end
