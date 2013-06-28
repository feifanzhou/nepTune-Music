class AddCollectionOrderToMedia < ActiveRecord::Migration
  def change
    add_column :media, :collection_order, :integer
  end
end
