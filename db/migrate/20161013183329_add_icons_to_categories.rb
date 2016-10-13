class AddIconsToCategories < ActiveRecord::Migration
  def change
    add_attachment :categories, :selected_icon_1x
    add_attachment :categories, :selected_icon_2x
    add_attachment :categories, :selected_icon_3x

    Categories.all.each {}

    change_column_null ::categories, :selected_icon_1x, false
    change_column_null ::categories, :selected_icon_2x, false
    change_column_null ::categories, :selected_icon_3x, false
  end
end
