class UserSerializer < BaseSerializer
  attributes :email, :gender, :preferred_time, :weather_perception,
             :uid, :name, :auth_token, :auth_expires_at, :avatar_url,
             :created_at, :updated_at

  def avatar_url
    object.avatar.expiring_url(time = 3600)
  end
end
