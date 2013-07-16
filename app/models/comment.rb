# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  text       :string(255)
#  upvotes    :integer
#  location   :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :text, :upvotes, :location, :user
  after_initialize :defaults

  belongs_to :user
  has_many :media, as: :media_holder
  belongs_to :comment
  has_many :comments

  validates :user, presence: true

  def defaults
    self.upvotes ||= 1
  end

  def parent
    self.comment
  end

  def children
    self.comments
  end

  # returns comments sorted so that top comments show first in list
  def sorted_for_location(location)
    Comment.where(location: location, parent: nil).sort { |a,b| b.created_at <=> a.created_at }
  end
end
