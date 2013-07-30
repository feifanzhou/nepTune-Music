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
#  commenter_id     :integer
#  commenter_type   :string(255)
#

class Comment < ActiveRecord::Base
  attr_accessible :text, :upvotes, :location, :commenter, :parent, :comment_id, :commentable_id, :commentable_type, :commentings, :artists
  after_initialize :defaults

  # belongs_to :user
  belongs_to :commenter, polymorphic: true
  has_many :media, as: :media_holder
  belongs_to :comment
  has_many :comments
  # belongs_to :commentable, polymorphic: true
  # Need many-to-many polymorphic relation between comments and media/events/anything else
  # http://stackoverflow.com/questions/12287869/many-to-many-polymorphic-association-in-ruby-on-rails
  has_many :commentings

  with_options :through => :commentings, :source => :commentable do |c|
    c.has_many :media, source_type: 'Media'
    c.has_many :events, source_type: 'Event'
    c.has_many :songs, source_type: 'Song'
    c.has_many :albums, source_type: 'Album'
    c.has_many :artists, source_type: 'Artist'
  end

  # validates :user, presence: true

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
    c = Comment.where(opts)
    Comment.sort_comments(c)
  end

  def self.sorted_for_commentable(c)
    Comment.sort_comments(c.comments)
  end

  def self.sort_comments(c)
    c.sort { |a,b| b.created_at <=> a.created_at }
  end



end
