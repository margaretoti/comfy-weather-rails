class OutfitSerializer < BaseSerializer
  attributes :latitude, :longitude, :notes, :is_public, :photo_url,
             :outfit_weather_types, :weather_types

  def photo_url
    object.photo.url
  end
end
