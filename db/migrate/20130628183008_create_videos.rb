class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :path
      t.string :embedcode

      t.timestamps
    end
  end
end
