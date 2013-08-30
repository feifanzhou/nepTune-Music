# == Schema Information
#
# Table name: votes
#
#  id         :integer          not null, primary key
#  comment_id :integer
#  user_id    :integer
#  is_upvote  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vote < ActiveRecord::Base
  attr_accessible :comment_id, :is_upvote, :user_id
end
