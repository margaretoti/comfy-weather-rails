class WeatherForecast
  PERIODS = { morning: 7, afternoon: 15, evening: 19, daily: nil }
  attr_reader :latitude, :longitude, :period

  def initialize(latitude:, longitude:, period:)
    @latitude = latitude
    @longitude = longitude
    @period = period
  end

  def forecast
    @forecast ||= ForecastIO.forecast(latitude, longitude, time: Time.current.to_i)
  end

  def hourly_forecasts
    @hourly_forecasts ||= forecast.hourly.data
  end

  def forecast_intervals
    forecast_intervals = Hash.new
    PERIODS.each do |key, value|
      if value.present?
        forecast_intervals[key] = hourly_forecasts[value]
      else
        forecast_intervals[key] = forecast.daily.data[0]
      end
    end
    return forecast_intervals
  end

  def self.get_temperature(latitude:, longitude:, period: nil)
    new(latitude: latitude, longitude: longitude, period: nil).get_temperature
  end

  def get_temperature
    @temperature ||= forecast.hourly
                             .data[AFTERNOON_HOUR][PREFERRED_TEMPERATURE]
  end

  def self.get_weather(latitude:, longitude:, period: nil)
    new(latitude: latitude, longitude: longitude, period: period).get_weather
  end

  def get_weather
    if period.present? && (forecast_intervals.key? period.to_sym)
      forecast_intervals.select { |k,v| k == period.to_sym }
    else
      forecast_intervals.except(:daily)
    end
  end
end
