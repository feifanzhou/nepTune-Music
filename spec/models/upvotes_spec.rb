# == Schema Information
#
# Table name: upvotes
#
#  id         :integer          not null, primary key
#  comment_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  up         :boolean
#

require 'spec_helper'

describe Upvotes do
  pending "add some examples to (or delete) #{__FILE__}"
end
