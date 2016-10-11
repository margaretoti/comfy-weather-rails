class V1::OutfitsController < ApplicationController
  def index
    outfits = Outfit.all

    render json: outfits
  end

  def create
    outfit = Outfit.create!(outfit_params)
    Outfit.add_weather_type(outfit)

    render json: outfit
  end

  def update
    outfit = Outfit.find(params[:id])
    outfit_weather_type = outfit.outfit_weather_types.last
    if outfit_weather_type.update!(outfit_weather_type_params)
      render json: outfit
    else
      render json: outfit
    end
  end


  private
  def outfit_params
    params.
      require(:outfit).
      permit(:latitude, :longitude, :notes, :photo, :is_public).
      merge(user: current_user)
  end

  def outfit_weather_type_params
    params.
      require(:outfit_weather_type).
      permit(:rating)
  end
end
