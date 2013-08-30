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

require 'spec_helper'

describe PlayCount do
  pending "add some examples to (or delete) #{__FILE__}"
end
