class AddIsTemporaryToMedia < ActiveRecord::Migration
  def change
    add_column :media, :is_temporary, :boolean
  end
end
