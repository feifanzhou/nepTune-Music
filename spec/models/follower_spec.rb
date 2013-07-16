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

require 'spec_helper'

describe Follower do
  pending "add some examples to (or delete) #{__FILE__}"
end
