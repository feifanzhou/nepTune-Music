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
  attr_accessible :name, :track_number

  belongs_to :artist
  belongs_to :album

  has_one :image, as: :media_holder
  has_one :audio, as: :media_holder

  def image
    return super || self.album.image || nil  # super reads attribute :image
  end
end
