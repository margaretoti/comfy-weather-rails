class RemoveRatingFromOutfits < ActiveRecord::Migration
  def change
    remove_column :outfits, :rating, :integer
  end
end
