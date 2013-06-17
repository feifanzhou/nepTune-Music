# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  caption    :string(255)
#  path       :string(255)
#  height     :integer
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :integer
#  song_id    :integer
#  is_primary :boolean
#  event_id   :integer
#

require 'spec_helper'

describe Image do
  pending "add some examples to (or delete) #{__FILE__}"
end
