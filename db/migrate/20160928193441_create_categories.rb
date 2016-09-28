class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, id: :uuid  do |t|
      t.timestamps null: false
      
      t.string :name, null: false
      t.attachment :icon, null: false
    end
  end
end
