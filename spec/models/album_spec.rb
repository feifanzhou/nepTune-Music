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
  before do
    @artist = FactoryGirl.create(:artist)
    @album = Album.new(artist: @artist)
  end

  it { should respond_to(:name) }
  it { should respond_to(:artist) }
  it { should be_valid }

  describe "without artist" do
    before { @album.artist = nil }
    it { should_not be_valid }
  end

end
