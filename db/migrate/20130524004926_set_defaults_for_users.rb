class SetDefaultsForUsers < ActiveRecord::Migration
  def up
    change_column :users, :willingToBetaTest, :boolean, default: false
    change_column :users, :isBetaTester, :boolean, default: false
    change_column :users, :isArtist, :boolean, default: false
  end

  def down
    # Currently can't remove default values
    raise ActiveRecord::IrreversibleMigration, "Can't remove default values"
  end
end
