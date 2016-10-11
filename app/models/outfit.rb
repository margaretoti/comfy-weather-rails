class Outfit < ActiveRecord::Base
  belongs_to :user

  has_many :outfit_article_of_clothings
  has_many :article_of_clothings, through: :outfit_article_of_clothings
  has_many :outfit_weather_types
  has_many :weather_types, through: :outfit_weather_types
  accepts_nested_attributes_for :outfit_weather_types, allow_destroy: true

  has_attached_file :photo

  validates_attachment :photo,
  content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/gif', 'image/png'] }

  validates :user, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :notes, length: { maximum: 250 }

  def self.add_weather_type(outfit)
    weather = WeatherForecast.get_weather(latitude: outfit.latitude,
    longitude: outfit.longitude, period: 'afternoon')
    weather_type = WeatherType.where("temp_range @> ?", weather[:afternoon]["apparentTemperature"].round).first
    outfit.weather_types << weather_type
  end
end
