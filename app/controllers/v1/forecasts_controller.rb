class V1::ForecastsController < ApplicationController
  def create
    forecast = WeatherForecast.get_weather(latitude: params[:latitude],longitude: params[:longitude])
    hourly_forecasts = forecast.hourly.data
    morning_forecast = hourly_forecasts[7]
    afternoon_forecast = hourly_forecasts[15]
    evening_forecast = hourly_forecasts[19]

    case params[:period]
    when "morning"
      render :json => {:morning_forecast => morning_forecast}
    when "afternoon"
      render :json => {:afternoon_forecast => afternoon_forecast}
    when "evening"
      render :json => {:evening_forecast => evening_forecast}
    else
      render :json => {:hourly_forecasts => hourly_forecasts}
    end
  end
end
