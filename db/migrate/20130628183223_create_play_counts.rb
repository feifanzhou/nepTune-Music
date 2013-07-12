class CreatePlayCounts < ActiveRecord::Migration
  def change
    create_table :play_counts do |t|
      t.integer :media_id
      t.integer :user_id
      t.integer :count

      t.timestamps
    end
  end
end
