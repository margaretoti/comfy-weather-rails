class Outfit < ActiveRecord::Base
  belongs_to :user

  has_many :outfit_article_of_clothings, dependent: :destroy
  has_many :article_of_clothings, through: :outfit_article_of_clothings, dependent: :destroy
  has_many :outfit_weather_types, dependent: :destroy
  has_many :weather_types, through: :outfit_weather_types

  has_attached_file :photo

  validates_attachment :photo,
  content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/gif', 'image/png'] }

  validates :user, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :notes, length: { maximum: 250 }

  def add_weather_type
    weather = WeatherForecast.get_weather(latitude: latitude,
                                          longitude: longitude,
                                          period: 'afternoon')
    weather_type = WeatherType.where('temp_range @> ?',
                                     weather[:afternoon]['apparentTemperature'].round)
                              .first
    weather_types << weather_type
  end

  def self.falls_into_weather_type(temperature)
    Outfit.joins(:weather_types).where('temp_range @> ?', temperature.round)
  end

  def self.fetch_outfit_by_date(date)
    outfit_of_the_day = Outfit.where("DATE(created_at) = ?", date).first
    if !outfit_of_the_day
      outfit_of_the_day = Outfit.where("DATE(created_at) = ?", Date.current).first
    end
    outfit_of_the_day
  end
end
