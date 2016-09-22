FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "user#{n}@factory.com" }
    gender 1
    preferred_time "2016-09-16 09:19:45"
    weather_perception 1
    provider "MyString"
    uid "MyString"
    name "MyString"
    oauth_token "MyString"
    oauth_expires_at "2016-09-16 09:19:45"
    avatar { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'),
       'image/png') }
  end
end
