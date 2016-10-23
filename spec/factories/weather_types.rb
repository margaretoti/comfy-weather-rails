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

  trait :chilly do
    temp_range 0...5
  end

  trait :chilly_85 do
    temp_range 85...90
  end

  trait :toasty do
    temp_range 95...100
  end

  trait :underflow do
    temp_range -10...-5
  end
end
