class AddBetaTestAndMusicianStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :willingToBetaTest, :boolean
    add_column :users, :isBetaTester, :boolean
    add_column :users, :isArtist, :boolean
  end
end
