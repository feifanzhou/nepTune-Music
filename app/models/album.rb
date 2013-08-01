# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer
#  year       :integer
#

class Album < ActiveRecord::Base
  attr_accessible :artist, :name, :image, :year

  belongs_to :artist
  has_one :image, as: :media_holder
  has_many :songs
  has_many :comments, as: :commentable
  # has_many :commentings, :as => :commentable
  # has_many :comments, :through => :commentings

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
