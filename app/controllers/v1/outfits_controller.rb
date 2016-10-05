class V1::OutfitsController < ApplicationController
  def index
    outfits = Outfit.all

    render json: outfits
  end

  def create
    outfit = Outfit.create!(outfit_params)

    render json: outfit
  end

  private
  def outfit_params
    params.require(:outfit).permit(:notes, :photo, :is_public).merge(user: current_user)
  end
end
