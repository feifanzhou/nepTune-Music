class CreateInfluences < ActiveRecord::Migration
  def change
    create_table :influences do |t|
      t.integer :artist_id
      t.integer :influence_id
      t.timestamps
    end
  end
end
