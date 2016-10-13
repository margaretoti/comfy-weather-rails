class OutfitSerializer < BaseSerializer
  AFTERNOON_HOUR = 15

  has_many :article_of_clothings

  attributes :latitude, :longitude, :notes, :is_public, :photo_url,
             :rating, :weather

  def photo_url
    object.photo.url
  end

  def rating
    object.outfit_weather_types.last.rating
  end

  def weather
    ForecastIO
      .forecast(object.latitude, object.longitude, time: object.created_at.to_i)
      .hourly.data[AFTERNOON_HOUR].as_json(only: [:summary, :icon,
                                                  :precipProbability,
                                                  :temperature,
                                                  :apparentTemperature])
  end
end
