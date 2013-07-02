# == Schema Information
#
# Table name: songs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  artist_id    :integer
#  album_id     :integer
#  track_number :integer

class Song < ActiveRecord::Base
  attr_accessible :name, :track_number, :audio, :image, :artist, :album

  belongs_to :artist
  belongs_to :album

  has_one :image, as: :media_holder
  has_one :audio, as: :media_holder

  validates :audio, presence: true
  validates :artist, presence: true

  def image
    return super || (self.album && self.album.image) || nil  # super reads attribute :image
  end

  def name
    return super || (self.audio && self.audio.name)
  end
end
