class AddUpToUpvotes < ActiveRecord::Migration
  def change
    add_column :upvotes, :up, :boolean
  end
end
