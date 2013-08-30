class AddArtistIdToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :artist_id, :integer
  end
end
