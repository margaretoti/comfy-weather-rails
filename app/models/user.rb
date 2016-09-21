class User < ActiveRecord::Base
  enum gender: { male: 0, female: 1, other: 2 }
  enum weather_perception: { chilly:0, neutral: 1, warm: 2 }

  validates_presence_of :name, :uid, :oauth_token, :oauth_expires_at
  validates_uniqueness_of :email

  def self.populating_from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
