include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :user do
    sequence(:email){|n| "user#{n}@factory.com" }
    sequence(:uid){|n| "#{n}"}
    gender 1
    preferred_time Time.now
    weather_perception 1
    provider "MyString"
    name "MyString"
    auth_token { SecureRandom.hex(20).encode('UTF-8') }
    auth_expires_at 60.days.from_now
    avatar { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.png'),
       'image/png') }
  end
end
