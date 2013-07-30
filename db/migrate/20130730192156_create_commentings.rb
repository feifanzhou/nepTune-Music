class CreateCommentings < ActiveRecord::Migration
  def change
    create_table :commentings do |t|
      t.integer "commentable_id"
      t.string "commentable_type"
      t.timestamps
    end
  end
end
