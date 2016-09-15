class CreateOutfits < ActiveRecord::Migration
  def change
    create_table :outfits do |t|
      t.integer :rating
      t.string :notes
      t.boolean :is_public

      t.timestamps null: false
    end
  end
end
