class MakeArtistAnIndependentClass < ActiveRecord::Migration
  def change
  	add_column :artists, :artistname, :string
    remove_column :users, :type
  end
end
