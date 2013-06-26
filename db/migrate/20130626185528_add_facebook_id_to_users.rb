class AddFacebookIdToUsers < ActiveRecord::Migration
  def change
  	# http://stackoverflow.com/questions/8503042/
    add_column :users, :facebook_id, :integer, limit: 8	# Bigint
  end
end
