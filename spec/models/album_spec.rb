# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer
#

require 'spec_helper'

describe Album do
  pending "add some examples to (or delete) #{__FILE__}"
end
