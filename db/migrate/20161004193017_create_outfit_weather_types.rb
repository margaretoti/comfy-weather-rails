class CreateOutfitWeatherTypes < ActiveRecord::Migration
  def change
    create_table :outfit_weather_types, id: :uuid do |t|
      t.timestamps null: false

      t.integer :rating, null: false
      t.references :outfit, type: :uuid, index: true, foreign_key: true, null: false
      t.references :weather_type, type: :uuid, index: true, foreign_key: true, null: false
    end
  end
end
