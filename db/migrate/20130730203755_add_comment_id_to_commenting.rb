class AddCommentIdToCommenting < ActiveRecord::Migration
  def change
    add_column :commentings, :comment_id, :integer
  end
end
