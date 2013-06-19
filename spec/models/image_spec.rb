# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  caption        :string(255)
#  path           :string(255)
#  height         :integer
#  width          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  is_primary     :boolean
#  imageable_id   :integer
#  imageable_type :string(64)
#

require 'spec_helper'

describe Image do
  pending "add some examples to (or delete) #{__FILE__}"
end
