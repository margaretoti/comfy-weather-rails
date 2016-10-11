class OutfitWeatherType < ActiveRecord::Base
  belongs_to :outfit
  belongs_to :weather_type
  accepts_nested_attributes_for :weather_type

  validates :outfit, presence: true
  validates :weather_type, presence: true
end
