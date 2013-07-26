# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  text             :string(255)
#  upvotes          :integer
#  location         :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  comment_id       :integer
#  commentable_id   :integer
#  commentable_type :string(64)
#

class Comment < ActiveRecord::Base
  attr_accessible :text, :upvotes, :location, :user, :parent, :comment_id
  after_initialize :defaults

  belongs_to :user
  has_many :media, as: :media_holder
  belongs_to :comment
  has_many :comments
  belongs_to :commentable, polymorphic: true

  validates :user, presence: true

  def defaults
    self.upvotes ||= 1
  end

  def parent
    self.comment
  end

  def parent=(p)
    self.comment = p
  end

  def children
    self.comments
  end

  def sorted_children
    self.children.sort { |a,b| a.created_at <=> b.created_at }
  end

  # returns comments sorted so that top comments show first in list
  def self.sorted_for_location(location)
    opts = {location: location, comment_id: nil}
    if not location
      opts.delete(location)
    end
    Comment.where(opts).sort { |a,b| b.created_at <=> a.created_at }
  end


end
