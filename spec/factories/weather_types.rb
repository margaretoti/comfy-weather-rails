FactoryGirl.define do
  factory :weather_type do
    sequence(:temp_range) {|n| (n + 50)...60}
    precip_type nil
  end
end
