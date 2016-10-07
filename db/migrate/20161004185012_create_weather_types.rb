class CreateWeatherTypes < ActiveRecord::Migration
  def change
    create_table :weather_types, id: :uuid do |t|
      t.timestamps null: false

      t.int4range :temp_range, null: false
      t.integer :precip_type
    end
  end
end
