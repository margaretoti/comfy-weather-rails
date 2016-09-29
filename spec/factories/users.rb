include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "user#{n}@factory.com" }
    sequence(:uid){|n| "#{n}"}
    gender 1
    preferred_time "2016-09-16 09:19:45"
    weather_perception 1
    provider "MyString"
    name "MyString"
    auth_token { SecureRandom.hex(20).encode('UTF-8') }
    auth_expires_at "2016-09-16 09:19:45"
    avatar { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.png'),
       'image/png') }
  end
end
