# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: artists
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  type                :string(255)
#  artistname          :string(255)
#  story               :text
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  route               :string(255)
#

class Artist < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :artistname, :story, :route, :contact_info

  has_attached_file :avatar, s3_protocol: 'http'

  has_one :contact_info, as: :contactable
  has_many :songs
  has_many :albums
  has_many :events, foreign_key: :creator_id
  has_many :media, as: :media_holder, class_name: "Media"
  has_many :band_members
  has_many :users, through: :band_members
  has_many :followings
  has_many :users, through: :followings
  has_many :artists, through: :followings
  has_many :inverse_followings, :class_name => "Following", :foreign_key => "artist_id"
  has_many :inverse_followers, :through => :inverse_followings, :source => :artist
  has_many :influences
  has_many :artists, through: :influences
  has_many :inverse_influences, :class_name => "Influence", :foreign_key => "influence_id"
  has_many :inverse_artists, :through => :inverse_influences, :source => :artist

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

  def is_headless
    return self.route.blank?
  end

  def media_for_location(loc)
    return Media.where(media_holder_id: self.id, location: loc.to_s).order('collection_order ASC')
  end

  def add_band_member(user)
    BandMember.create(artist_id: self.id, user_id: user.id)
  end

end
