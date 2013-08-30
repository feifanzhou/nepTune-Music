class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :upvotes
      t.string :location
      t.belongs_to :user

      t.timestamps
    end
  end
end
