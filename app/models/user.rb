class User < ActiveRecord::Base
  enum gender: { male: 0, female: 1, other: 2 }
  enum weather_perception: { chilly:0, neutral: 1, warm: 2 }

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :outfits, dependent: :destroy

  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true
  validates :auth_token, presence: true, uniqueness: true
  validates :auth_expires_at, presence: true
  validates :email, presence: true

  def self.populating_from_koala(graph)
    find_or_initialize_by(uid: graph["id"]).tap do |user|
      user.provider = "facebook"
      user.uid = graph["id"]
      user.name = graph["name"]
      user.email = graph["email"]
      user.avatar = "https://graph.facebook.com/#{graph["id"]}/picture" if !user.avatar?
    end
  end

  def self.for_auth(token)
    where(auth_token: token).
      where('auth_expires_at > ?', Time.current).first
  end

  def reset_token!
    AuthToken.reset(user: self)
  end
end
