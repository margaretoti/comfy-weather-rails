class ArticleOfClothingSerializer < BaseSerializer
  attributes :description, :frequency, :category

  def frequency
    object.frequency
  end
end
