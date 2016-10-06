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
    weather_type = WeatherType.new(weather_type_attributes)
    weather_type.save!

    render json: weather_type
  end

  def update
    weather_type = WeatherType.find(params[:id])
    if weather_type.update!(weather_type_attributes)
      render json: weather_type
    else
      render json: weather_type
    end
  end

  private

  def weather_type_params
    params.
      require(:weather_type).
      permit(:low, :high, :precip_type)
  end

  def weather_type_attributes
    attrs = weather_type_params
    low = attrs.delete(:low)
    high = attrs.delete(:high)
    temp_range = (low..high)

    attrs.merge(temp_range: temp_range)
  end
end
