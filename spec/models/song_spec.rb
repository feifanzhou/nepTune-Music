# == Schema Information
#
# Table name: songs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  artist_id    :integer
#  album_id     :integer
#  track_number :integer
#

require 'spec_helper'

describe Song do
  before do
    @artist = Artist.create(artistname: 'drwho')
    @user = User.create(fname: 'Pierre', lname: 'Karashchuk', email: 'pierre@nottaken.com', isArtist: false, password: 'foobar')
    @image = Image.new(caption: 'Hits Volume 1', custom_path: 'https://dl.dropboxusercontent.com/u/7828009/nepTuneTest/pg1.jpg', height: 600, width: 600, media_holder: @artist)
    @audio = Audio.new(name: "Next Stop Everywhere", custom_path: 'https://dl.dropboxusercontent.com/u/16963685/dr_who_next_stop_everywhere.mp3')
    @album = Album.create(name: 'Hits Volume 1', image: @image)
    @song = Song.new(name: "waka waka", audio: @audio, image: @image, artist: @artist, album: @album)
  end

  subject { @song }

  it { should be_valid }

  describe "missing field" do
    describe "artist" do
      before { @song.artist = nil }
      it { should_not be_valid }
    end

    describe "audio" do
      before { @song.audio = nil }
      it { should_not be_valid }
    end
  end

  describe "fallbacks -- " do
    describe "no image to album image" do
      before { @song.image = nil }
      it { should be_valid }
      its(:image) { should == @song.album.image }
    end

    describe "no name to audio name" do
      before { @song.name = nil }
      it { should be_valid }
      its(:name) { should == @song.audio.name }
    end
  end

end
