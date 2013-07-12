class CreateContactInfos < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.string :phone
      t.string :email
      t.string :website
      t.integer :contactable_id
      t.string :contactable_type, limit: 64

      t.timestamps
    end
  end
end
