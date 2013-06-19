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
#

class Attendee < ActiveRecord::Base
  attr_accessible :status
  validates_inclusion_of :status, in: [:performing, :invited, :going, :maybe]

  belongs_to :user
  belongs_to :event

  def status
  	read_attribute(:status).to_sym
  end

  def status=(value)
  	write_attribute(:status, value.to_s)
  end
end
