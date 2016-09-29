class V1::ForecastsController < ApplicationController
  def index
    weather = ForecastIO.forecast(params[:latitude],params[:longitude])
    current_weather = weather.currently
    render json: current_weather
  end
end
