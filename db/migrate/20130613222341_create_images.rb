class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :caption
      t.string :path
      t.integer :height
      t.integer :width

      t.timestamps
    end
  end
end
