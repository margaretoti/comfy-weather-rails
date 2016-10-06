class AddLocationToOutfits < ActiveRecord::Migration
  def change
    add_column :outfits, :longitude, :decimal, null: false
    add_column :outfits, :latitude, :decimal, null: false
  end
end
