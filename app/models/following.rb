# == Schema Information
#
# Table name: followings
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  target_id  :integer
#  user_id    :integer
#  artist_id  :integer
#

class Following < ActiveRecord::Base
  attr_accessible :target_id, :user_id, :artist_id

  belongs_to :user
  belongs_to :artist
  belongs_to :target, class_name: 'Artist'
end
