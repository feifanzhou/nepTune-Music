class AddDefaultToCredits < ActiveRecord::Migration
  def up
    change_column :users, :credits, :integer, :default => 0
  end

  def down
    change_column :users, :credits, :integer, :default => nil
  end
end
