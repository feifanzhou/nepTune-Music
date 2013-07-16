class AddIsFollowingToFollower < ActiveRecord::Migration
  def change
    add_column :followers, :is_following, :boolean
  end
end
