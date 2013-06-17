# == Schema Information
#
# Table name: songs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  album_id     :integer
#  track_number :integer
#

class Song < ActiveRecord::Base
  attr_accessible :name

  belongs_to :artist
  has_one :image
  belongs_to :album

  def image
  	return super || self.album.image || nil  # super reads attribute :image
  end
end
