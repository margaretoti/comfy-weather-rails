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
    ## recommended_outfit = nil
    recommended_outfits = []
    recommended_outfit_score = Float::INFINITY

    outfits.each do |outfit|
      outfit_score = calculate_outfit_score(outfit, current_temperature)
      if outfit_score < recommended_outfit_score
        recommended_outfit_score = outfit_score
        ## recommended_outfit = outfit
      end
    end

    # 3. Create an array of the recommended outfits that have the lowest
    # recommended outfit score that is no more than 1 temp range away from the
    # current temperature
    if recommended_outfit_score > 5
      puts 'no good outfits because they are all 5 or more degrees away'

      render json: []
    else
      outfits.each do |outfit|
        outfit_score = calculate_outfit_score(outfit, current_temperature)
        if outfit_score == recommended_outfit_score
          recommended_outfits.push(outfit)
        end
      end

      # 4. Sort the recommended outfits array by date and store the oldest worn one
      recommended_outfits.sort_by! { |recommended_outfit| recommended_outfit.created_at }
      recommended_outfit = recommended_outfits[0]

      render json: recommended_outfit
    end
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
  def calculate_outfit_score(outfit, current_temperature)
    # Currently, an outfit only has one unique weather type. This should always pass
    weather_type = outfit.weather_types.first

    reference_temperature = (weather_type.temp_range.first + weather_type.temp_range.last) / 2

    if outfit.rating = "toasty"
      reference_temperature = reference_temperature - 5
    elsif outfit.rating = "chilly"
      reference_temperature = reference_temperature + 5
    return (current_temperature - reference_temperature).abs
    end
  end

end
