class SimplifyFollowers < ActiveRecord::Migration
  def change
    remove_column :followers, :user_id
    remove_column :followers, :artist_id
    remove_column :followers, :is_following
    add_column :followers, :target_id, :integer
    add_column :followers, :user_id, :integer
    add_column :followers, :artist_id, :integer
  end
end
