# == Schema Information
#
# Table name: media
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  details           :string(255)
#  type              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  location          :string(255)
#  collection_order  :integer
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  height            :integer
#  width             :integer
#  is_primary        :boolean
#  media_holder_id   :integer
#  media_holder_type :string(64)
#  custom_path       :string(255)
#

class Video < Media
  attr_accessible :collection_order, :custom_path, :embedcode

  def show_html
  	# Only returns Youtube iframe
  	# This is temporary to test rest of editing
  	return "<iframe width='640' height='360' src='#{ self.custom_path }' frameborder='0' allowfullscreen></iframe>".html_safe
  end
end
