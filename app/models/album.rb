# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Album < ActiveRecord::Base
  attr_accessible :name

  belongs_to :artist
  has_one :image
  has_many :songs

  def songs
  	songs_list = super	# Read original song list
  	return songs_list.sort_by{ |s| s[:track_number] }
  end
end
