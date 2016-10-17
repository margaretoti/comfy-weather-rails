class V1::OutfitsController < ApplicationController
  def index
    temperature = WeatherForecast.get_temperature(latitude: params[:latitude],
                                                  longitude: params[:longitude])
    outfits = Outfit.falls_into_weather_type(temperature)

    render json: outfits
  end

  def show
    outfit = Outfit.fetch_outfit_by_date(date)

    render json: outfit
  end

  def create
    outfit = Outfit.create!(outfit_params)

    if article_of_clothings
      article_of_clothings.each do |article_of_clothing_id|
        @article = OutfitArticleOfClothing.create!(outfit_id: outfit.id,
                                                  article_of_clothing_id: article_of_clothing_id)
      end
    end

    outfit.add_weather_type
    outfit.outfit_weather_types.last.update!(rating: params[:rating])
    outfit.valid?

    render json: outfit
  end

  def update
    outfit = Outfit.find(params[:id])
    outfit_weather_type = outfit.outfit_weather_types.last
    outfit_weather_type.update!(outfit_weather_type_params)

    render json: outfit
  end

  def recommend
    # Afternoon temperature passed from front-end thus params[:latitude]
    temperature = WeatherForecast.get_weather(latitude: params[:latitude],
                                              longitude: params[:longitude])

    # Find outfits where the temperature falls in this range
    # Check rating to see if comfy
    comfy_outfits = Outfit.falls_into_weather_type(temperature).where(rating: "comfy").order(created_at: :asc)
    recommended_outfit = comfy_outfits[0]

    render json: recommended_outfit

    # If no comfy find toasty outfits
    toasty_outfits = Outfit.falls_into_weather_type(temperature).where(rating: "toasty").order(created_at: :asc)
    recommended_outfit = toasty_outfits[0]

    render json: recommended_outfit

    # If no toasty find chilly
    chilly_outfits = Outfit.falls_into_weather_type(temperature).where(rating: "chilly").order(created_at: :asc)
    recommended_outfit = chilly_outfits[0]

    render json: recommended_outfit

    # Otherwise return an error
    puts 'no appropriate outfit for current temperature range'

    # render json: recommended_outfit
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

  def article_of_clothings
    params[:article_of_clothings]
  end

  def date
    if params[:date]
      Date.parse(params[:date])
    else
      Date.current
    end
  end
end
