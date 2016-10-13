class RemoveIconsFromCategories < ActiveRecord::Migration
  def change
    remove_attachment :categories, :unselected_icon
    remove_attachment :categories, :selected_icon
  end
end
