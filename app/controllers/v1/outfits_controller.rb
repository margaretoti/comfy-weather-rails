class V1::OutfitsController < ApplicationController
  def index
    outfits = Outfit.all

    render json: outfits
  end

  def show
    outfit = Outfit.find(params[:id])

    render json: outfit
  end

  def create
    outfit = Outfit.create!(outfit_params)
    outfit.add_weather_type

    render json: outfit
  end

  def update
    outfit = Outfit.find(params[:id])
    outfit_weather_type = outfit.outfit_weather_types.last
    outfit_weather_type.update!(outfit_weather_type_params)

    render json: outfit
  end

  private

  def outfit_params
    params
      .require(:outfit)
      .permit(:latitude, :longitude, :notes, :photo, :is_public)
      .merge(user: current_user)
  end

  def outfit_weather_type_params
    params
      .require(:outfit_weather_type)
      .permit(:rating)
  end
end
