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

  before_validation do
    # Create temporary password
    if !self.password or self.password.blank?
      # From http://stackoverflow.com/a/88341/472768
      self.password = temporary_password
      self.has_temp_password = true
    end
  end
  # before_save { |user| user.email = email.downcase }
  # before_save { |user| user.artistname = artistname.downcase unless artistname.blank? }

  has_secure_password

  before_save { create_remember_token if (self.password_digest && defined?(self.password_digest)) }

  validates :fname, presence: true, length: { maximum: 50 }
  validates :lname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  # validates :artistname, uniqueness: { case_sensitive: false }, allow_nil: true;




  def display_name
    return "#{ self.fname } #{ self.lname }"
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
