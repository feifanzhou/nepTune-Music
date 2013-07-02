# == Schema Information
#
# Table name: artists
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string(255)
#  artistname :string(255)
#  story      :text
#

require 'spec_helper'


describe Artist do
  before { @artist = Artist.new(artistname: 'john@example.com') }

  subject { @artist }

  it { should respond_to(:artistname) }
  it { should respond_to(:songs) }
  it { should respond_to(:albums) }
  it { should respond_to(:media) }
  it { should respond_to(:band_members) }
  it { should respond_to(:followers) }

  it { should be_valid }

  it { @artist.isArtist }

  describe "with no artistname" do
    before { @artist.artistname = " " }

    it { should_not be_valid }
  end

end
