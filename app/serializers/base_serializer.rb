class BaseSerializer < ActiveModel::Serializer
  attributes :id, :updated_at, :created_at
end
