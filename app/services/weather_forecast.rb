class WeatherForecast
  MORNING_HOUR = 7
  AFTERNOON_HOUR = 15
  EVENING_HOUR = 19

  attr_reader :latitude, :longitude, :period
  def initialize(latitude:, longitude:, period:)
    @latitude = latitude
    @longitude = longitude
    @period = period
  end

  def self.get_weather(latitude:, longitude:, period: nil)
    new(latitude: latitude, longitude: longitude, period: period).get_weather
  end

  def get_weather
    forecast = ForecastIO.forecast(latitude, longitude)
    hourly_forecasts = forecast.hourly.data
    case period
    when "morning"
      morning_forecast = hourly_forecasts[MORNING_HOUR]
    when "afternoon"
      afternoon_forecast = hourly_forecasts[AFTERNOON_HOUR]
    when "evening"
      evening_forecast = hourly_forecasts[EVENING_HOUR]
    else
      current_forecast = forecast.currently
    end
  end
end
