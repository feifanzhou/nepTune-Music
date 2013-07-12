class AddStoryToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :story, :text
  end
end
