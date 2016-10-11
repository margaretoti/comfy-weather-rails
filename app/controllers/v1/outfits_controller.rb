class V1::OutfitsController < ApplicationController
  def index
    outfits = Outfit.all

    render json: outfits
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

    article_of_clothing_params.each do |article_of_clothing_id|
      @article = ArticleOfClothing.find(article_of_clothing_id)
      if (defined? @article) != nil
        outfit_articles = OutfitArticleOfClothing.create!(article_of_clothing_id: article_of_clothing_id, outfit: outfit)
      else
        puts "The article of clothing with id #{article_of_clothing_id} does not exist."
      end
    end

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

  def article_of_clothing_params
    params.require(:article_of_clothings)
  end
end
