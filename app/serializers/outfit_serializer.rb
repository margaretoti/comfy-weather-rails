class OutfitSerializer < BaseSerializer
  AFTERNOON_HOUR = 15

  has_many :article_of_clothings
  attributes :user_id, :latitude, :longitude, :notes, :is_public, :photo_url,
             :latest_rating, :weather

  def photo_url
    object.photo.url
  end

  def latest_rating
     if object.outfit_weather_types.present?
       object.outfit_weather_types.order("updated_at").last.rating
     else
       nil
     end
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
