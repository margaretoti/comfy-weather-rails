FactoryGirl.define do
  factory :outfit_weather_type do
    association :outfit
    association :weather_type
  end
end
