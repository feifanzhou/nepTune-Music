class AddLocationToMedia < ActiveRecord::Migration
  def change
    add_column :media, :location, :string
  end
end
