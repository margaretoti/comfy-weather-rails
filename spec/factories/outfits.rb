FactoryGirl.define do
  factory :outfit do
    user
    rating 1
    notes "MyString"
    is_public false
  end
end
