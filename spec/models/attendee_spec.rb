# == Schema Information
#
# Table name: attendees
#
#  id         :integer          not null, primary key
#  status     :string(16)
#  user_id    :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  artist_id  :integer
#

require 'spec_helper'

describe Attendee do
  before {
    @user = User.new(fname: 'John', lname: 'Smith', email: 'john@example.com', password: "foobar")
    @artist = Artist.new(artistname: "wakawaka")
    @event = Event.new
    @attendee = Attendee.create(user: @user, status: :going, event: @event)
    p @attendee
  }

  subject { @attendee }

  it { should be_valid }

  describe "status should be symbol" do
    it { @attendee.status.class.should == Symbol}

    describe "even in database" do
      before{ @a = Attendee.find_by_id(@attendee.id) }

      it { @a.status.class.should == Symbol }

    end

  end

  describe "should not be valid with bad status" do
    before { @attendee.status = :killing }

    it{ should_not be_valid }

  end

  describe "with blank status" do
    it { @attendee.status = nil
      should_not be_valid }

    it { @attendee.status = " "
      should_not be_valid }

  end

  describe "with no event" do
    before { @attendee.event = nil }
    it { should_not be_valid }
  end

  describe "with no artist nor user" do
    before { @attendee.user = nil }
    it { should_not be_valid }
  end

  describe "with artist but no user" do
    before { @attendee.user = nil }
    it { should_not be_valid }
  end

  describe "with user but no artist" do
    before do
      @attendee.user = @user
      @attendee.artist = nil
    end

    it { should be_valid }
  end

  describe "with artist but no user" do
    before do
      @attendee.user = nil
      @attendee.artist = @artist
    end

    it { should be_valid }
  end

  describe "with both user and artist" do
    before do
      @attendee.user = @user
      @attendee.artist = @artist
    end

    it { should_not be_valid }

  end

end
