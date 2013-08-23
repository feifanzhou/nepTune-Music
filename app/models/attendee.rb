# == Schema Information
#
# Table name: attendees
#
#  id         :integer          not null, primary key
#  status     :string(16)
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer
#

class Attendee < ActiveRecord::Base
  attr_accessible :status, :user, :artist, :event, :user_id, :artist_id, :event_id
  validates :status, presence: true
  validates_inclusion_of :status, in: [:performing, :invited, :going, :maybe]
  validates :event, presence: true

  validate :should_have_user_or_artist

  belongs_to :user
  belongs_to :artist
  belongs_to :event

  def should_have_user_or_artist
    if user.blank? and artist.blank?
      errors.add(:base, "user or artist should be present")
    elsif not user.blank? and not artist.blank?
      errors.add(:base, "user and artist should not both be present")
    end
  end

  def status
    s = read_attribute(:status)
    if s
      s.to_sym
    end
  end

  # def status=(value)
  #   write_attribute(:status, value.to_s)
  # end
end
