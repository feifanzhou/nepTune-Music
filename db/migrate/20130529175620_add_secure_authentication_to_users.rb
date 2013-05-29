class AddSecureAuthenticationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_temp_password, :boolean
    add_column :users, :remember_token, :string
  end
end
