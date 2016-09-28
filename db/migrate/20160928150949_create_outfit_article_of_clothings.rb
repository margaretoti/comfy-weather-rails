class CreateOutfitArticleOfClothings < ActiveRecord::Migration
  def change
    create_table :outfit_article_of_clothings, id: :uuid do |t|

      t.timestamps null: false
      t.references :outfit, type: :uuid, index: true, foreign_key: true, null: false
      t.references :article_of_clothing, type: :uuid, index: true, foreign_key: true, null: false
    end
  end
end
