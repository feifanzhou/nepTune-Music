class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.integer :amount
      t.string :token
      t.integer :user_id

      t.timestamps
    end
  end
end
