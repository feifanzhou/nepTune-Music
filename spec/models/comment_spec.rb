# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  text             :string(255)
#  upvotes          :integer
#  location         :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  comment_id       :integer
#  commentable_id   :integer
#  commentable_type :string(64)
#

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
