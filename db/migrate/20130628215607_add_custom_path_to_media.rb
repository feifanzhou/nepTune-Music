class AddCustomPathToMedia < ActiveRecord::Migration
  def change
    add_column :media, :custom_path, :string
  end
end
