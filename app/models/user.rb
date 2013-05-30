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
#

class User < ActiveRecord::Base
  attr_accessible :email, :fname, :lname, :password, :willingToBetaTest, :isArtist, :has_temp_password
  
  before_validation do
    # Create temporary password 
    if !self.password or self.password.blank?
      # From http://stackoverflow.com/a/88341/472768
      self.password = (0...16).map{ ('a'..'z').to_a[rand(26)] }.join
      self.has_temp_password = true
    end
  end
  before_save { |user| user.email = email.downcase }
  
  has_secure_password
  
  before_save { create_remember_token if (self.password_digest && defined?(self.password_digest)) }
  
  validates :fname, presence: true, length: { maximum: 50 }
  validates :lname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  
  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
