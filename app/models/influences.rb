# == Schema Information
#
# Table name: influences
#
#  id           :integer          not null, primary key
#  artist_id    :integer
#  influence_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Influences < ActiveRecord::Base
  # attr_accessible :title, :body
end
