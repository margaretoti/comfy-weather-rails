class V1::OutfitsController < ApplicationController
  def index
    outfits = Outfit.all

    render json: outfits
  end

  def create
    outfit = Outfit.create(outfit_params.except(:photo))
    binding.pry
    ImageUploader.perform(outfit: outfit, base64_string: outfit_params[:photo])
    outfit.save
    render json: outfit
  end

  private
  def outfit_params
    params.require(:outfit).permit(:rating, :notes, :photo, :is_public)
  end
end
