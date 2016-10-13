FactoryGirl.define do
  factory :weather_type do
    temp_range 50...55
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
