# == Schema Information
#
# Table name: commentings
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  comment_id       :integer
#

require 'spec_helper'

describe Commenting do
  pending "add some examples to (or delete) #{__FILE__}"
end
