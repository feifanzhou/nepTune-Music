# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string(255)
#  artistname :string(255)
#  story      :text
#

class Artist < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :artistname, :story

  has_one :contact_info, as: :contactable
  has_many :songs
  has_many :albums
  has_many :events, foreign_key: :creator_id
  has_many :media, as: :media_holder, class_name: "Media"
  has_many :band_members
  has_many :users, through: :band_members
  has_many :followers
  has_many :users, through: :followers, as: :fans

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

  def media_for_location(loc)
    return Media.where(media_holder_id: self.id, location: loc.to_s).order('collection_order ASC')
  end

  def add_band_member(user)
    BandMember.create(artist_id: self.id, user_id: user.id)
  end

end
