class ArticleOfClothingSerializer < BaseSerializer
  attributes :description, :frequency

  def frequency
    object.frequency
  end
end
