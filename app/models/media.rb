# == Schema Information
#
# Table name: media
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  details           :string(255)
#  type              :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  location          :string(255)
#  collection_order  :integer
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  height            :integer
#  width             :integer
#  is_primary        :boolean
#  media_holder_id   :integer
#  media_holder_type :string(64)
#  custom_path       :string(255)
#

class Media < ActiveRecord::Base
  attr_accessible :name, :details, :location, :height, :width, :is_primary, :file

  belongs_to :media_holder, polymorphic: true

  has_many :play_counts
  has_many :users, through: :play_counts
  has_attached_file :file, s3_protocol: 'https', s3_permissions: { original: :private }

  def self.for_location(loc)
  	return Media.find_by_location(loc.to_s, order: "collection_order ASC")
  end

  def show_html
    raise "SubclassResponsibility"
  end

  # http://stackoverflow.com/a/17154985/472768
  scope :primary, where(is_primary: true)
end
