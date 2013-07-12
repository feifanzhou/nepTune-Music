class AddPathToMedia < ActiveRecord::Migration
  def change
    add_column :media, :path, :string
  end
end
