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

  validates :user, presence: true

  def defaults
    self.upvotes ||= 1
  end
end
