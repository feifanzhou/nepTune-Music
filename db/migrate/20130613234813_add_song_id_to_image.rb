class AddSongIdToImage < ActiveRecord::Migration
  def change
    add_column :images, :song_id, :integer
  end
end
