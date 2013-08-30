class AddNameIndexToAlbums < ActiveRecord::Migration
  def change
  	add_index :albums, :name, :COLLATE => :NOCASE
  end
end
