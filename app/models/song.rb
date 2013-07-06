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

  # validates :audio, presence: true
  validates :artist, presence: true

  def image
    rescue_image = nil
    # TODO: Never really loads song_default, album_default is used if default image is needed
    if (self.album.blank? || self.album.image.blank?)
      rescue_image = super || Image.new(custom_path: '/images/song_default.png', name: 'Missing song image')
    else
      rescue_image = self.album.image
    end
    logger.debug("song rescue_image: #{ rescue_image }")
    # If there is album art, return that for an image without its own image
    # If there is no album art, return default song image
    return super || rescue_image || nil  # super reads attribute :image
  end

  def name
    return super || (self.audio && self.audio.name)
  end
end
