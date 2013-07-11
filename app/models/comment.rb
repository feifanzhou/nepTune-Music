class Comment < ActiveRecord::Base
  attr_accessible :text, :upvotes, :location, :user
  after_initialize :defaults

  belongs_to :user
  has_many :media, as :media_holder

  validates :user, presence: true

  def defaults
    self.upvotes ||= 1
  end
end
