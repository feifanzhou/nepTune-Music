class ChangeDataModelsToArtistClass < ActiveRecord::Migration
  def change
  	rename_column :albums, :user_id, :artist_id
  	rename_column :songs, :user_id, :artist_id
  end
end
