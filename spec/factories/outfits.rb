FactoryGirl.define do
  factory :outfit do
    latitude 37.792
    longitude -122.393
    notes "MyString"
    is_public false
    user
    weather_type
  end
end
