# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  caption    :string(255)
#  path       :string(255)
#  height     :integer
#  width      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ActiveRecord::Base
  attr_accessible :caption, :height, :path, :width

  belongs_to :album
  belongs_to :song
end
