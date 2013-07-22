class AddRoutesToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :route, :string
  end
end
