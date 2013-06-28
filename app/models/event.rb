# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_at   :datetime
#  end_at     :datetime
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ActiveRecord::Base
  attr_accessible :creator_id, :end_at, :name, :start_at

  belongs_to :creator, class_name: 'Artist', foreign_key: :creator_id
  has_many :images, as: :media_holder
  has_many :attendees
  has_many :users, through: :attendees
  has_many :artists, through: :attendees

  def cover_image
    return self.images.primary.first || self.images.first
  end

  def performers
    # map: http://stackoverflow.com/a/5216299/472768
    return self.attendees.where(status: :performing).map(&:artist)
  end

  def invited
    return self.attendees.where(status: :invited).map(&:user)
  end

  def going
    return self.attendees.where(status: :going).map(&:user)
  end

  def maybe_going
    return self.attendees.where(status: :maybe).map(&:user)
  end
end
