# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  text             :text
#  upvotes_total    :integer
#  location         :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  comment_id       :integer
#  commentable_id   :integer
#  commentable_type :string(64)
#  commenter_id     :integer
#  commenter_type   :string(255)
#  rating           :float
#

require 'spec_helper'

describe Comment do
  pending "add some examples to (or delete) #{__FILE__}"
end
