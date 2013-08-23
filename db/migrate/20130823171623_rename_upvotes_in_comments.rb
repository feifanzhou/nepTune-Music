class RenameUpvotesInComments < ActiveRecord::Migration
  def change
    rename_column :comments, :upvotes, :upvotes_total
  end
end
