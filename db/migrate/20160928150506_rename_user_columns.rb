class RenameUserColumns < ActiveRecord::Migration
  def change
    rename_column :users, :oauth_token, :auth_token
    rename_column :users, :oauth_expires_at, :auth_expires_at
  end
end
