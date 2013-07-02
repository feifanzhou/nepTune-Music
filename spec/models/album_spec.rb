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
  before { @album = Album.new }

  it { should respond_to(:name) }

end
