class AddIconsToCategories < ActiveRecord::Migration
  def change
    add_attachment :categories, :selected_icon_1x
    add_attachment :categories, :selected_icon_2x
    add_attachment :categories, :selected_icon_3x
  end
end
