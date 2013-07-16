# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_at   :datetime
#  end_at     :datetime
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  details    :string(255)
#  location   :string(255)
#

require 'spec_helper'

describe Event do

  before do
    @user = User.create(fname: 'Pierre', lname: 'Karashchuk', email: 'pierre@not_taken.com', isArtist: true, password: 'foobar')
    @artist = Artist.create(artistname: 'pierre')
    @artist.add_band_member(@user)
    @event = Event.new(name: "Pierre's birthday'",
                       start_at: DateTime.new(1994, 5, 23),
                       end_at: DateTime.new(1994, 5, 23).succ(),
                       creator: @artist)
  end

  subject { @event }

  it { should be_valid }

  describe "methods" do
    let (:methods) { %i(creator start_at end_at name performers invited going maybe_going) }
    it "should work" do
      methods.each do |m|
        should respond_to(m)
      end
    end
  end

  describe "end date before start date" do
    before do
      @event.start_at = DateTime.new(1994, 5, 23)
      @event.end_at   = DateTime.new(1994, 5, 22)
    end

    it { should_not be_valid }
  end

  describe "missing field" do
    describe "start date" do
      before { @event.start_at = nil }
      it { should_not be_valid }
    end

    describe "end date" do
      before { @event.end_at = nil }
      it { should_not be_valid }
    end

    describe "creator" do
      before { @event.creator = nil }
      it { should_not be_valid }
    end

    describe "name" do
      before { @event.name = " " }
      it { should_not be_valid }
    end
  end
end
