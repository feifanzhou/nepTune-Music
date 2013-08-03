class AddRatingToComments < ActiveRecord::Migration
  def change
    add_column :comments, :rating, :float
  end
end
