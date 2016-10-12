class OutfitSerializer < BaseSerializer
<<<<<<< HEAD
  AFTERNOON_HOUR = 15
  
  has_many :article_of_clothings

=======
>>>>>>> b29489a... add env variable for afternoon_hour, modify resource restrictions in route
  attributes :latitude, :longitude, :notes, :is_public, :photo_url,
             :outfit_weather_types, :weather_types, :weather

  def photo_url
    object.photo.url
  end

  def weather
    ForecastIO
      .forecast(object.latitude, object.longitude, time: object.created_at.to_i)
      .hourly.data[env['AFTERNOON_HOUR']]
  end
end
