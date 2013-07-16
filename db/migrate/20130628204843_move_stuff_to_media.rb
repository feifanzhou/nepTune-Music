class MoveStuffToMedia < ActiveRecord::Migration
  def change
    remove_column :media, :path

    add_column :media, :height, :integer
    add_column :media, :width, :integer
    add_column :media, :is_primary, :boolean

    add_column :media, :media_holder_id, :integer
    add_column :media, :media_holder_type, :string, limit: 64

    drop_table :images
    drop_table :videos
  end
end
