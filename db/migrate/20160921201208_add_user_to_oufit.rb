class AddUserToOufit < ActiveRecord::Migration
  def change
    add_reference :outfits, :user, index: true, foreign_key: true, type: :uuid
  end
end
