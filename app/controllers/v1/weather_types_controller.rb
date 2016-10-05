class V1::WeatherTypesController < ApplicationController
  def index
    weather_types = WeatherType.all

    render json: weather_types
  end

  def show
    weather_type = WeatherType.find(params[:id])

    render json: weather_type
  end

  def create
    weather_type = WeatherType.create(weather_type_params)
    weather_type.save!

    render json: weather_type
  end

  def update
    weather_type = WeatherType.find(params[:id])
    if weather_type.update!(weather_type_params)
      render json: weather_type
    else
      render json: weather_type
    end
  end

  private
  def temp_range_params
    params[:low]..params[:high]
  end

  def weather_type_params
    params.
      require(:weather_type).
      permit(temp_range_params, :precip_type)
  end
end
