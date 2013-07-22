# == Schema Information
#
# Table name: followings
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  artist_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_following :boolean
#

class Following < ActiveRecord::Base
  attr_accessible :target_id, :user_id, :artist_id

  belongs_to :user
  belongs_to :artist
  belongs_to :target, class_name: 'Artist'
end
