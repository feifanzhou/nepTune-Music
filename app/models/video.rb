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

class Video < Media
  attr_accessible :embedcode, :path

  def show_html
  end
end
