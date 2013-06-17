# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  caption    :string(255)
#  path       :string(255)
#  height     :integer
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :integer
#  song_id    :integer
#  is_primary :boolean
#  event_id   :integer
#

class Image < ActiveRecord::Base
  attr_accessible :caption, :height, :path, :width, :is_primary

  belongs_to :album
  belongs_to :song
  belongs_to :event

  # http://stackoverflow.com/a/17154985/472768
  scope :primary, where(is_primary: true)
end
