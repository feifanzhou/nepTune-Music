# == Schema Information
#
# Table name: followers
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  artist_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_following :boolean
#

class Follower < ActiveRecord::Base
  attr_accessible :artist_id, :is_following, :user_id

  belongs_to :artist
  belongs_to :user
end