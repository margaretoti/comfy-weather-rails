class CreateOutfits < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :outfits, id: :uuid do |t|
      t.timestamps null: false

      t.integer :rating, null: false
      t.attachment :photo
      t.text :notes, limit: 250
      t.boolean :is_public
    end
  end
end
