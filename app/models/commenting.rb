# == Schema Information
#
# Table name: commentings
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  comment_id       :integer
#

class Commenting < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :comment
  belongs_to :commentable, polymorphic: true
end
