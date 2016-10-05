class OutfitSerializer < BaseSerializer
  attributes :notes, :is_public, :photo_url

  def photo_url
    object.photo.url
  end
end
