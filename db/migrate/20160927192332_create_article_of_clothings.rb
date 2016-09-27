class CreateArticleOfClothings < ActiveRecord::Migration
  def change
    create_table :article_of_clothings do |t|

      t.timestamps null: false
    end
  end
end
