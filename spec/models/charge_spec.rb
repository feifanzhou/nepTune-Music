# == Schema Information
#
# Table name: charges
#
#  id         :integer          not null, primary key
#  amount     :integer
#  token      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Charge do
  pending "add some examples to (or delete) #{__FILE__}"
end
