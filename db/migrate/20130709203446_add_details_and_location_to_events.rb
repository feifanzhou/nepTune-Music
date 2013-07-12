class AddDetailsAndLocationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :details, :string
    add_column :events, :location, :string
  end
end
