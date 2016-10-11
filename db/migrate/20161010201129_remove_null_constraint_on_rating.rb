class RemoveNullConstraintOnRating < ActiveRecord::Migration
  def change
    change_column :outfit_weather_types, :rating, :integer, :null => true
  end
end
