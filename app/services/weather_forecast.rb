class WeatherForecast
  PERIODS = { morning: 7, afternoon: 15, evening: 19, current: nil }
  attr_reader :latitude, :longitude, :period

  def initialize(latitude:, longitude:, period:)
    @latitude = latitude
    @longitude = longitude
    @period = period
  end

  def forecast
    @forecast ||= ForecastIO.forecast(latitude, longitude)
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
        forecast_intervals[key] = forecast.currently
      end
    end
    return forecast_intervals
  end

  def self.get_weather(latitude:, longitude:, period: nil)
    new(latitude: latitude, longitude: longitude, period: period).get_weather
  end

  def get_weather
    if period.present? && (forecast_intervals.key? period.to_sym)
      forecast_intervals.select { |k,v| k == period.to_sym }
    else
      forecast_intervals.except(:current)
    end
  end
end
