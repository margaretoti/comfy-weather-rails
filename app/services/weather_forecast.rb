class WeatherForecast
  attr_reader :latitude, :longitude
  def initialize(latitude:, longitude:)
    @latitude = latitude
    @longitude = longitude
  end

  def self.get_weather(latitude:, longitude:)
    new(latitude: latitude, longitude: longitude).get_weather
  end

  def get_weather
    ForecastIO.forecast(latitude, longitude)
  end
end
