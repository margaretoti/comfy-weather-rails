class CreateArticleOfClothings < ActiveRecord::Migration
  def change
    create_table :article_of_clothings, id: :uuid do |t|
      t.timestamps null: false

      t.string :description, null: false
      t.references :user, type: :uuid, index: true, foreign_key: true
    end
  end
end
