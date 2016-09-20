class V1::OutfitsController < ApplicationController
  def index
    outfits = Outfit.all

    render json: outfits
  end

  def create
    outfit = Outfit.new(outfit_params)
    outfit.save
    # redirect_to @outfit
    # binding.pry
    render json: outfit
  end

  private
  def outfit_params
    # binding.pry
    params.require(:outfit).permit(:rating, :notes, :photo, :is_public)
  end
end
