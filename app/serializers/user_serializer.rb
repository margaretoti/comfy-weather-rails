class UserSerializer < BaseSerializer
  attributes :name, :email, :gender, :weather_perception, :preferred_time,
             :avatar_file_name
end
