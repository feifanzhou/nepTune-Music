class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :comment_id
      t.integer :user_id
      t.boolean :is_upvote

      t.timestamps
    end
  end
end
