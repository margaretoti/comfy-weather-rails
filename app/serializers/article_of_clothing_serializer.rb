class ArticleOfClothingSerializer < BaseSerializer
  attributes :description, :frequency, :category_name, :category_id

  def frequency
    object.frequency
  end

  def category_name
    object.category.name
  end
end
