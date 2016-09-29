class V1::ForecastsController < ApplicationController
  def create
    forecast = WeatherForecast.get_weather(latitude: params[:latitude],
    longitude: params[:longitude], period: params[:period])
    render json: forecast, serializer: ForecastSerializer
  end
end
