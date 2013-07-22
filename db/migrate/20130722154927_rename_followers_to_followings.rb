class RenameFollowersToFollowings < ActiveRecord::Migration
  def change
  	rename_table :followers, :followings
  end
end
