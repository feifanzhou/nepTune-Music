# == Schema Information
#
# Table name: media
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  details           :string(255)
#  type              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  location          :string(255)
#  collection_order  :integer
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  height            :integer
#  width             :integer
#  is_primary        :boolean
#  media_holder_id   :integer
#  media_holder_type :string(64)
#  custom_path       :string(255)
#

require 'spec_helper'

describe Media do
  before do
    @artist = Artist.create(artistname: 'thepianoguys')
    @user = User.create(fname: 'Pierre', lname: 'Karashchuk', email: 'pierre@nottaken.com', isArtist: false, password: 'foobar')
    @image = Image.new(caption: 'Hits Volume 1', custom_path: 'https://dl.dropboxusercontent.com/u/7828009/nepTuneTest/pg1.jpg', height: 600, width: 600, media_holder: @artist)
    @video = Video.new(name: "Moonlight - Electric Cello", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/DRVvFYppU0w?rel=0', collection_order: 6, media_holder: @artist)
    @audio = Audio.new(name: "Next Stop Everywhere", custom_path: 'https://dl.dropboxusercontent.com/u/16963685/dr_who_next_stop_everywhere.mp3')
  end

  subject { @image }

  describe "methods" do
    let (:methods) { %i(name details location file path custom_path media_holder is_primary media_holder) }
    it "should respond" do
      methods.each do |m|
        should respond_to(m)
      end
    end
  end

  describe "image only" do
    it { @image.should respond_to(:caption) }
  end

  describe "with path but not custom_path" do
    before do
      @image.path = 'https://dl.dropboxusercontent.com/u/7828009/nepTuneTest/pg1.jpg'
      @image.custom_path = nil
    end
    it { should be_valid }
  end

  describe "with custom_path but not path" do
    before do
      @image.custom_path = 'https://dl.dropboxusercontent.com/u/7828009/nepTuneTest/pg1.jpg'
      @image.path = nil
    end
    it { should be_valid }
  end

  describe "with neither custom_path nor path" do
    before do
      @image.custom_path = nil
      @image.path = nil
    end
    it { should_not be_valid }
  end

end
