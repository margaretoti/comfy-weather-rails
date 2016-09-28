class User < ActiveRecord::Base
  enum gender: { male: 0, female: 1, other: 2 }
  enum weather_perception: { chilly:0, neutral: 1, warm: 2 }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :outfits

  validates_presence_of :name, :uid, :oauth_token, :oauth_expires_at
  validates_uniqueness_of :email

  def self.populating_from_koala(graph)
    find_or_initialize_by(uid: graph["id"]).tap do |user|
      user.provider = "facebook"
      user.uid = graph["id"]
      user.name = graph["name"]
      r = open("https://graph.facebook.com/#{graph["id"]}/picture")
      user.avatar_content_type = "image/jpg"
      user.avatar_file_size = r.length
      user.avatar_file_name = "#{graph["name"]}_avatar"
      user.avatar_updated_at = Time.now
    end
  end
end
