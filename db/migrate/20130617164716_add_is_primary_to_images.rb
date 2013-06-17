class AddIsPrimaryToImages < ActiveRecord::Migration
  def change
    add_column :images, :is_primary, :boolean
  end
end
