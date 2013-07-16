class AddSoundmapNumbersToSong < ActiveRecord::Migration
  def change
    add_column :songs, :soundmap_numbers, :string
  end
end
