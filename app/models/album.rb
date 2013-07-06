# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer
#

class Album < ActiveRecord::Base
  attr_accessible :name, :artist, :image

  belongs_to :artist
  has_one :image, as: :media_holder
  has_many :songs

  validates :artist, presence: true
  validates :name, presence: true

  def image
    return super || Image.new(custom_path: '/images/album_default.png', name: 'Missing album art') || nil
  end

  def songs
    songs_list = super	# Read original song list
    return songs_list.sort_by{ |s| s[:track_number] }
  end
end
