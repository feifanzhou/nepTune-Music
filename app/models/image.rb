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
#  is_temporary      :boolean
#

class Image < Media
  attr_accessible :caption

  def caption=(s)
    self.name = s
  end

  def caption
    self.name
  end

  def self.default_album_image
    img = Image.find_by_custom_path('/images/album_default.png')
    img ||= Image.create(custom_path: '/images/album_default.png')
    return img
  end

  def self.default_song_image
    img = Image.find_by_custom_path('/images/song_default.png')
    img ||= Image.create(custom_path: '/images/song_default.png')
    return img
  end

  def show_html
  	return "<img src='#{ self.path }' alt='#{ self.name }' />".html_safe
  end
end
