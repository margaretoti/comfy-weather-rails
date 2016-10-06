FactoryGirl.define do
  factory :outfit do
    user
    latitude 37.792
    longitude -122.393
    notes "MyString"
    is_public false
  end
end
