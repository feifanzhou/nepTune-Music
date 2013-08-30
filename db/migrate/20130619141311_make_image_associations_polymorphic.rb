class MakeImageAssociationsPolymorphic < ActiveRecord::Migration
  def change
  	remove_column :images, :album_id
  	remove_column :images, :song_id
  	remove_column :images, :event_id

  	add_column :images, :imageable_id, :integer
  	add_column :images, :imageable_type, :string, limit: 64

  	add_index :images, [:imageable_type, :imageable_id]
  end
end
