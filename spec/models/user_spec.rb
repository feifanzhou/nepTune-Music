# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  fname               :string(255)
#  lname               :string(255)
#  email               :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  willingToBetaTest   :boolean          default(FALSE)
#  isBetaTester        :boolean          default(FALSE)
#  isArtist            :boolean          default(FALSE)
#  password_digest     :string(255)
#  has_temp_password   :boolean
#  remember_token      :string(255)
#  username            :string(255)
#  is_group            :boolean          default(FALSE)
#  facebook_id         :integer
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

require 'spec_helper'
#require 'faker'

include UsersHelper

describe User do
  before { @user = User.new(fname: 'John', lname: 'Smith', email: 'john@example.com', password: "foobar") }

  subject { @user }

  it { should respond_to(:fname) }
  it { should respond_to(:lname) }
  it { should respond_to(:email) }
  it { should respond_to(:isArtist) }

  it { should be_valid }

  describe "first name" do
    describe "is not present" do
      before { @user.fname = " " }
      it { should_not be_valid }
    end
    describe "is too long" do
      before { @user.fname = 'a' * 51 }
      it { should_not be_valid }
    end
  end

  describe "last name" do
    describe "is not present" do
      before { @user.lname = " " }
      it { should_not be_valid }
    end
    describe "is too long" do
      before { @user.lname = 'a' * 51 }
      it { should_not be_valid }
    end
  end

  describe "email" do
    describe "is not present" do
      before { @user.email = " " }
      it { should_not be_valid }
    end
    describe "is not valid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          @user.should_not be_valid
        end
      end
    end
    describe "is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          @user.should be_valid
        end
      end
    end
    describe "is already taken" do
      before do
        user_same_email = @user.dup
        user_same_email.email = @user.email.upcase
        user_same_email.save
      end
      it { should_not be_valid }
    end
  end

  describe "random user" do
    describe "first name" do
      it "should be valid" do
        10.times do
          @user.fname = Faker::Name.first_name()
          if not @user.valid?
            $stderr.puts @user.fname
          end
          @user.should be_valid
        end
      end
    end

    describe "last name" do
      it "should be valid" do
        10.times do
          @user.lname = Faker::Name.last_name()
          if not @user.valid?
            $stderr.puts @user.lname
          end
          @user.should be_valid
        end
      end
    end

    describe "email" do
      it "should be valid" do
        10.times do
          @user.email = Faker::Internet.email()
          if not @user.valid?
            $stderr.puts @user.email
          end
          @user.should be_valid
        end
      end
    end
  end


  describe "profanities" do
    let (:bad_words) { BAD_WORDS }

    describe "-- first name" do
      it "should be invalid" do
        BAD_WORDS.each do |word|
          name = Faker::Name.first_name
          pos = rand(name.length+1)
          bad_name = String.new(name).insert(pos, rand_case(word))
          @user.fname = bad_name
          @user.should_not be_valid
        end
      end
    end

    describe "-- last name" do
      it "should be invalid" do
        BAD_WORDS.each do |word|
          name = Faker::Name.last_name
          pos = rand(name.length+1)
          bad_name = String.new(name).insert(pos, rand_case(word))
          @user.lname = bad_name
          @user.should_not be_valid
        end
      end
    end

  end
end
