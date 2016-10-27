class OutfitRecommender
  attr_reader :temperature

  def initialize(user:, temperature:)
    @user = user
    @temperature = temperature
  end

  def self.recommended_outfit(user:, temperature:)
    new(user: user, temperature: temperature).recommended_outfit
  end

  def recommended_outfit
    @outfit ||= get_best_outfit(@user, @temperature)
  end

  def get_best_outfit(user, temperature)
    outfit = get_outfit(user, temperature, 1) ||
             get_outfit(user, temperature + 5, 2) ||
             get_outfit(user, temperature - 5, 0)
  end

  def get_outfit(user, temperature, rating)
    outfits = Outfit.falls_into_weather_type(temperature)
                    .joins(:outfit_weather_types)
                    .where(outfit_weather_types: { rating: rating })
                    .where(user_id: user.id)
                    .order(created_at: :asc)
    outfits.try(:first)
  end
end
