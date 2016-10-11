class CategorySerializer < BaseSerializer
  attributes :name, :selected_icon_url, :unselected_icon_url

  def selected_icon_url
    object.selected_icon.url
  end

  def unselected_icon_url
    object.unselected_icon.url
  end
end
