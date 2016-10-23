FactoryGirl.define do
  factory :outfit do
    latitude 42.36
    longitude -71.06
    notes 'MyString'
    is_public false
    user

    factory :outfit_with_comfy_weather_types do
      transient do
        weather_type { create :weather_type }
      end

      after :create do |outfit, evaluator|
        outfit.weather_types << evaluator.weather_type
        outfit.save
        outfit_weather_type = outfit.outfit_weather_types
                                    .where(weather_type: evaluator.weather_type)
                                    .first
        outfit_weather_type.rating = 'comfy'
        outfit_weather_type.save
      end
    end

    factory :outfit_with_chilly_weather_types do
      transient do
        weather_type { create :weather_type, :chilly }
      end

      after :create do |outfit, evaluator|
        outfit.weather_types << evaluator.weather_type
        outfit.save
        outfit_weather_type = outfit.outfit_weather_types
                                    .where(weather_type: evaluator.weather_type)
                                    .first
        outfit_weather_type.rating = 'chilly'
        outfit_weather_type.save
      end
    end

    factory :outfit_with_chilly_weather_types_85 do
      transient do
        weather_type { create :weather_type, :chilly_85 }
      end

      after :create do |outfit, evaluator|
        outfit.weather_types << evaluator.weather_type
        outfit.save
        outfit_weather_type = outfit.outfit_weather_types
                                    .where(weather_type: evaluator.weather_type)
                                    .first
        outfit_weather_type.rating = 'chilly'
        outfit_weather_type.save
      end
    end

    factory :outfit_with_toasty_weather_types do
      transient do
        weather_type { create :weather_type, :toasty }
      end

      after :create do |outfit, evaluator|
        outfit.weather_types << evaluator.weather_type
        outfit.save
        outfit_weather_type = outfit.outfit_weather_types
                                    .where(weather_type: evaluator.weather_type)
                                    .first
        outfit_weather_type.rating = 'toasty'
        outfit_weather_type.save
      end
    end
  end
end
