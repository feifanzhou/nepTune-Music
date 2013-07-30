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
#  details    :string(255)
#  location   :string(255)
#

class Event < ActiveRecord::Base
  attr_accessible :creator_id, :end_at, :name, :start_at, :creator, :location, :details

  belongs_to :creator, class_name: 'Artist', foreign_key: :creator_id
  has_many :images, as: :media_holder
  has_many :attendees
  has_many :users, through: :attendees
  has_many :artists, through: :attendees
  # has_many :comments, as: :commentable
  has_many :commentings, :as => :commentable
  has_many :comments, :through => :commentings

  validates :name, presence: true
  validates :creator, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  validate :should_have_start_before_end

  def should_have_start_before_end
    if start_at and end_at and start_at > end_at
      errors.add(:end_at, "must be later than start time")
    end
  end

  def display_time_string
    date_end_string = 'th'
    case self.start_at.day % 10
    when 1
      date_end_string = 'st'
    when 2
      date_end_string = 'nd'
    when 3
      date_end_string = 'rd'
    end
    date_end_string = 'th' if self.start_at.day == 11 || self.start_at.day == 12 || self.start_at.day == 13
    display_string = self.start_at.strftime("%b. %-d#{ date_end_string }")
    d = self.start_at.to_date
    t = self.start_at.strftime("%l:%M %P")
    if d == Date.today
      display_string = "Today, #{ t }"
    elsif d == Date.tomorrow
      display_string = "Tomorrow, #{ t }"
    elsif d < Date.today
      display_string = "Already passed"
    elsif d <= Date.today.end_of_week
      display_string = d.strftime("%A") + ", #{ t }"
    end
    return display_string
  end

  def cover_image
    return self.images.primary.first || self.images.first || Image.new(custom_path: '/images/concert.jpg', name: 'Default event cover') || nil
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
