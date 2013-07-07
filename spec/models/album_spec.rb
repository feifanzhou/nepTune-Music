# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer
#  year       :integer
#

require 'spec_helper'

describe Album do
  before do
    @artist = FactoryGirl.create(:artist)
    @album = Album.new(name: "Touch of Grey", artist: @artist)
  end

  subject { @album }

  it { should respond_to(:name) }
  it { should respond_to(:artist) }
  it { should respond_to(:image) }
  it { should respond_to(:songs) }
  it { should be_valid }

  describe "without artist" do
    before { @album.artist = nil }
    it { should_not be_valid }
  end

  describe "with blank name" do
    before { @album.name = " " }
    it { should_not be_valid }
  end


end
