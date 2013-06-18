class Artist < User
  # attr_accessible :title, :body

  has_many :songs
  has_many :albums
  has_many :events, foreign_key: :creator_id
  
end
