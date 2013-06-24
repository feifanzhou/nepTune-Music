# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  fname             :string(255)
#  lname             :string(255)
#  email             :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  willingToBetaTest :boolean          default(FALSE)
#  isBetaTester      :boolean          default(FALSE)
#  isArtist          :boolean          default(FALSE)
#  password_digest   :string(255)
#  has_temp_password :boolean
#  remember_token    :string(255)
#  is_group          :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :password, :willingToBetaTest, :isArtist, :has_temp_password, :artistname

  attr_accessor :artistname

  include UsersHelper

  has_many :attendees
  has_many :events, through: :attendees


  # before_save { |user| user.email = email.downcase }
  # before_save { |user| user.artistname = artistname.downcase unless artistname.blank? }
  after_validation do
    self.errors.messages.delete(:password_digest)
  end


  has_secure_password

  before_save { create_remember_token if (self.password_digest && defined?(self.password_digest)) }

  validates :fname, presence: true, length: { maximum: 50 }
  validates :lname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, too_short: "should have at least %{count} characters" }
  # validates :artistname, uniqueness: { case_sensitive: false }, allow_nil: true;

  validate :should_not_have_profanities


  def should_not_have_profanities
    if is_profane_name? fname or is_profane_name? lname
      errors.add(:name, "shouldn't contain profanities")
    end

    if is_profane_name? email
      errors.add(:email, "shouldn't contain profanities")
    end

  end

  DISPLAY_FIELDS = {fname: "First name", lname: "Last name", name: "Name", email: "Email", password: "Password" }

  def nice_messages
    out = []
    for tag, messages in errors.messages do
      nice_name = DISPLAY_FIELDS.fetch(tag, tag.to_s.capitalize)
      messages.each do |msg|
        m = "#{nice_name} #{msg}"
        m = m.sub(/\scan't\s/, " shouldn't ")
        out << m
      end
    end
    return out
  end

  def display_name
    return "#{ self.fname } #{ self.lname }"
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
