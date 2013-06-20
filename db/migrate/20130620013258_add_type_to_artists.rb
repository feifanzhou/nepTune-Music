class AddTypeToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :type, :string
  end
end
