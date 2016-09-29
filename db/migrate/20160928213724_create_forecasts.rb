class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
