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
    # 1. Get the current temperature using the longitude and latitude sent
    #    from the front end
    current_temperature = WeatherForecast.get_temperature(latitude: params[:latitude],
                                                          longitude: params[:longitude])

    # 2. Get all of the outfits where the weather range to encompasses the
    #    current temperature AND has a comfy rating AND belong to the current user
    #    AND order them by the oldest create_at date
    outfits = get_outfits(current_temperature, 1)
    recommended_outfit = nil

    # 3. If there are no outfits in the current temperature range,
    # a. Find and store the weather types/ranges that are one range above and
    #    one range below the current temperature range
    # b. Grab the toasty outfits in the range above and/or chilly outfits in
    #    the range below the current temperature range
    # c. Return a recommended_outfit
    if outfits.present?
      recommended_outfit = outfits.first
    else
      toasty_outfits = get_outfits(current_temperature + 5, 2)

      if toasty_outfits.present?
        recommended_outfit = toasty_outfits.first
      else
        chilly_outfits = get_outfits(current_temperature - 5, 0)
        if chilly_outfits.present?
          recommended_outfit = chilly_outfits.first
        end
      end
    end

    render json: recommended_outfit
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

  def get_outfits(temperature, rating)
    outfits = Outfit.falls_into_weather_type(temperature)
                    .joins(:outfit_weather_types)
                    .where(outfit_weather_types: { rating: rating })
                    .where(user_id: current_user.id)
                    .order(created_at: :asc)
    return outfits
  end
end
