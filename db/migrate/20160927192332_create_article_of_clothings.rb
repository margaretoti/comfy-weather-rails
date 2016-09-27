class CreateArticleOfClothings < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :article_of_clothings do |t|
      t.timestamps null: false

      t.string :description, null: false
    end
  end
end
