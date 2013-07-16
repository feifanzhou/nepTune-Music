class AddAvatarToArtists < ActiveRecord::Migration
  def self.up
  	add_attachment :artists, :avatar
  end

  def self.down
  	remove_attachment :artists, :avatar
  end
end
