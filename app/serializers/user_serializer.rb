class UserSerializer < BaseSerializer
  attributes :name, :email, :gender, :weather_perception, :preferred_time,
             :avatar_url
             
  def avatar_url
    object.avatar.expiring_url(time = 3600)
  end
end
