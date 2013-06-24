# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string(255)
#  artistname :string(255)
#

class Artist < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :artistname

  has_many :songs
  has_many :albums
  has_many :events, foreign_key: :creator_id
  has_many :band_members
  has_many :users, through: :band_members

  validates :artistname, presence: true

  def display_name
  	return self.artistname || super	# If username, return that
  end

  def members
  	return self.band_members.map(&:user)
  end

  def email		# Likely artist email will be nil, so return email of member
    return self.email || self.band_members.first.email || super
  end

  def isArtist
  	return true		# Every artist…is an artist
  end
  
end
