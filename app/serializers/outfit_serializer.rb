class OutfitSerializer < BaseSerializer
  AFTERNOON_HOUR = 15
  attributes :latitude, :longitude, :notes, :is_public, :photo_url,
             :outfit_weather_types, :weather_types, :weather

  def photo_url
    object.photo.url
  end

  def weather
    ForecastIO
      .forecast(object.latitude, object.longitude, time: object.created_at.to_i)
      .hourly.data[AFTERNOON_HOUR]
  end
end
