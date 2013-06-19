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
#  username          :string(255)
#

class Artist < User
  # attr_accessible :title, :body

  has_many :songs
  has_many :albums
  has_many :events, foreign_key: :creator_id
  
end
