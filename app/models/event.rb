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

  belongs_to :user, foreign_key: :creator_id
  has_many :images

  def cover_image
  	return self.images.primary.first || self.images.first
  end
end
