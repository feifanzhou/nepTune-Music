# == Schema Information
#
# Table name: play_counts
#
#  id         :integer          not null, primary key
#  media_id   :integer
#  user_id    :integer
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PlayCount < ActiveRecord::Base
  attr_accessible :count, :media_id, :user_id
end
