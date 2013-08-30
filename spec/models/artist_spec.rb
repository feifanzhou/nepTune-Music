# == Schema Information
#
# Table name: artists
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  type                :string(255)
#  artistname          :string(255)
#  story               :text
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  route               :string(255)
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

  describe "adding band members" do
    let (:user) { User.create(fname: 'Pierre', lname: 'Karashchuk', email: 'pierre@not_take.com', isArtist: false, password: 'foobar') }
    before do
      @artist.save
    end

    it "should make a new Band member" do
      lambda do
        @artist.add_band_member(user)
      end.should change(BandMember, :count).by(1)
    end

    describe "-- afterwards" do
      before { @artist.add_band_member(user) }
      it "proper band member must be created" do
        BandMember.find_by_user_id_and_artist_id(user.id, @artist.id).should_not be_nil
      end
    end
  end

end
