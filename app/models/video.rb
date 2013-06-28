# == Schema Information
#
# Table name: media
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  details          :string(255)
#  type             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  location         :string(255)
#  path             :string(255)
#  collection_order :integer
#

class Video < Media
  attr_accessible :embedcode, :path

  def show_html
  	# Only returns Youtube iframe
  	# This is temporary to test rest of editing
  	return "<iframe width='640' height='360' src='#{ self.path }' frameborder='0' allowfullscreen></iframe>"
  end
end
