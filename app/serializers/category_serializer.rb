class CategorySerializer < BaseSerializer
  attributes :name, :selected_icon_1x_url, :selected_icon_2x_url, :selected_icon_3x_url

  def selected_icon_1x_url
    object.selected_icon_1x.url
  end

  def selected_icon_2x_url
    object.selected_icon_2x.url
  end

  def selected_icon_3x_url
    object.selected_icon_3x.url
  end
end
