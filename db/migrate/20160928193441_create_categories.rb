class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, id: :uuid  do |t|
      t.timestamps null: false

      t.string :name, null: false
      t.attachment :icon, null: false
    end

    add_reference :article_of_clothings, :category, type: :uuid, index: true, foreign_key: true, null: false
  end
end
