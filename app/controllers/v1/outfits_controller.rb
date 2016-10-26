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

  # def recommend
  #   # 1. Get the current temperature and all the OutfitWeatherTypes
  #   current_temperature = params[:temperature].to_f
  #   outfits = Outfit.joins(:weather_types).all
  #
  #   # 2. Calculate the lowest recommended outfit score
  #   recommended_outfit = nil
  #   recommended_outfit_score = Float::INFINITY
  #
  #   # a. For each outfit, calculate it's outfit score
  #   outfits.each do |outfit|
  #     outfit_score = calculate_outfit_score(outfit, current_temperature)
  #     # b. If the current recommended outfit is nil,
  #     #    the outfit has a score less than the current recommended outfit score,
  #     #    or outfit score equals the recommended outfit score and the outfit created
  #     #    on date is less than the current recommended outfit created on date,
  #     #    set the recommended outfit to be the current outfit
  #     if (recommended_outfit == nil) || (outfit_score < recommended_outfit_score) ||
  #       (outfit_score == recommended_outfit_score && outfit.created_at < recommended_outfit.created_at)
  #       recommended_outfit_score = outfit_score
  #       recommended_outfit = outfit
  #     end
  #   end
  #
  #   # 3. Render the JSON for the recommended_outfit, unless the recommended
  #   #    outfit score is more than 1 temp range below or above
  #   #    the current temperature
  #   if recommended_outfit_score > 5
  #     recommended_outfit = nil
  #   end
  #
  #   render json: recommended_outfit
  # end

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
    if outfits.present?
      recommended_outfit = outfits.first
    else
      # additional_weather_types = find_similar_weather_types(outfit.weather_types)

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

  # Returns and array containing two weather types: the one above and the one
  # below the current weather type
  def find_similar_weather_types(weather_type)
    # This array stores the weather types in the ranges above and below
    # the current temperature range
    similar_weather_types = []

    # Order all of the existing weather types by temperature range
    all_weather_types = WeatherType.order_by(:temp_range)

    # Get index of your weather type in the weather_types array above
    selected_weather_type_index = all_weather_types.index(weather_type)

    # Take the weather type above and below the current weather type
    # and put them in return array
    if selected_weather_type_index != 0 &&
       selected_weather_type_index != (weather_types.length - 1)

       similar_weather_types.push(weather_types[selected_weather_type_index - 1])
       similar_weather_types.push(weather_types[selected_weather_type_index + 1])
    elsif selected_weather_type_index == 0
      similar_weather_types.push([])
      similar_weather_types.push(weather_types[selected_weather_type_index + 1])
    else
      similar_weather_types.push(weather_types[selected_weather_type_index - 1])
      similar_weather_types.push([])
    end

    return prioritzed_weather_types
  end

  # # Calulates outfit score where the score is the difference between the
  # # current temperature and an outfit's average temperature range
  # # Example: An outfit with temp range 70 to 74 has an outfit score of 72
  # def calculate_outfit_score(outfit, current_temperature)
  #   weather_type = outfit.weather_types.first # each outfit has one unique weather type
  #
  #   reference_temperature = (weather_type.temp_range.first +
  #                            weather_type.temp_range.last) / 2
  #
  #   if outfit.outfit_weather_types.first.rating == 'toasty'
  #     reference_temperature = reference_temperature - 5
  #   elsif outfit.outfit_weather_types.first.rating == 'chilly'
  #     reference_temperature = reference_temperature + 5
  #   end
  #
  #   (current_temperature - reference_temperature).abs
  # end
end
