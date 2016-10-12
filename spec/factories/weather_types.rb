FactoryGirl.define do
  factory :weather_type do
    sequence(:temp_range) {|n| (n + 50)...60}
    precip_type nil
  end

  trait :rain do
    precip_type 0
  end

  trait :snow do
    precip_type 1
  end

  trait :sleet do
    precip_type 2
  end

  trait :underflow do
    temp_range -10...-5
  end
end
