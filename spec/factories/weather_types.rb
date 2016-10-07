FactoryGirl.define do
  factory :weather_type do
    sequence(:temp_range) {|n| n..10}
    precip_type 1
  end
end
