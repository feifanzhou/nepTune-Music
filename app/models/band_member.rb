# == Schema Information
#
# Table name: band_members
#
#  id         :integer          not null, primary key
#  artist_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BandMember < ActiveRecord::Base
  attr_accessible :artist_id, :user_id

  belongs_to :user
  belongs_to :artist
end
