# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string(255)
#  artistname :string(255)
#

require 'spec_helper'

describe Artist do
  before { @artist = Artist.new(artistname: 'john@example.com') }

  subject { @artist }



end
