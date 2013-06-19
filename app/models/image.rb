# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  caption        :string(255)
#  path           :string(255)
#  height         :integer
#  width          :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  is_primary     :boolean
#  imageable_id   :integer
#  imageable_type :string(64)
#

class Image < ActiveRecord::Base
  attr_accessible :caption, :height, :path, :width, :is_primary

  belongs_to :imageable, polymorphic: true

  # http://stackoverflow.com/a/17154985/472768
  scope :primary, where(is_primary: true)
end
