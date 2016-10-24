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
    # 1. Get the current temperature and all the OutfitWeatherTypes
    current_temperature = params[:temperature].to_f
    outfits = Outfit.joins(:weather_types).all

    # 2. Calculate the lowest recommended outfit score
    recommended_outfit = nil
    recommended_outfit_score = Float::INFINITY

    # a. For each outfit, calculate it's outfit score
    outfits.each do |outfit|
      outfit_score = calculate_outfit_score(outfit, current_temperature)
      # b. If the current recommended outfit is nil,
      #    the outfit has a score less than the current recommended outfit score,
      #    or outfit score equals the recommended outfit score and the outfit created
      #    on date is less than the current recommended outfit created on date,
      #    set the recommended outfit to be the current outfit
      if (recommended_outfit == nil) || (outfit_score < recommended_outfit_score) ||
        (outfit_score == recommended_outfit_score && outfit.created_at < recommended_outfit.created_at)
        recommended_outfit_score = outfit_score
        recommended_outfit = outfit
      end
    end

    # 3. Render the JSON for the recommended_outfit, unless the recommended
    #    outfit score is more than 1 temp range below or above
    #    the current temperature
    if recommended_outfit_score > 5
      recommended_outfit = nil
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

  # Calulates outfit score where the score is the difference between the
  # current temperature and an outfit's average temperature range
  # Example: An outfit with temp range 70 to 74 has an outfit score of 72
  def calculate_outfit_score(outfit, current_temperature)
    weather_type = outfit.weather_types.first # each outfit has one unique weather type

    reference_temperature = (weather_type.temp_range.first +
                             weather_type.temp_range.last) / 2

    if outfit.outfit_weather_types.first.rating == 'toasty'
      reference_temperature = reference_temperature - 5
    elsif outfit.outfit_weather_types.first.rating == 'chilly'
      reference_temperature = reference_temperature + 5
    end

    (current_temperature - reference_temperature).abs
  end
end
