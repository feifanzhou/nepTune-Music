class Influence < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :artist
  belongs_to :influence, class_name: 'Artist'
end