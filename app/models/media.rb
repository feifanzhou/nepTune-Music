# == Schema Information
#
# Table name: media
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  details    :string(255)
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  location   :string(255)
#  path       :string(255)
#

class Media < ActiveRecord::Base
  attr_accessible :name, :details, :height, :path, :width, :is_primary

  has_many :play_counts
  has_many :users, through: :play_counts


  has_attached_file :file, s3_protocol: 'https', s3_permissions: {original: :private}

  def show_html
    raise "SubclassResponsibility"
  end
end
