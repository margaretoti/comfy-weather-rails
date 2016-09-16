class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :gender, :preferred_time, :weather_perception
end
