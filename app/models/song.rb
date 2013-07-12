# == Schema Information
#
# Table name: songs
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  artist_id        :integer
#  album_id         :integer
#  track_number     :integer
#  soundmap_numbers :string(255)
#

class Song < ActiveRecord::Base
  attr_accessible :name, :track_number, :audio, :image, :artist, :album

  include SoundmapHelper

  serialize :soundmap_numbers
  #after_commit :make_soundmap_worker
  before_save :make_soundmap

  belongs_to :artist
  belongs_to :album

  has_one :image, as: :media_holder
  has_one :audio, as: :media_holder

  validates :audio, presence: true
  validates :artist, presence: true

  def image
    return super || (self.album && self.album.image) || Image.find_by_custom_path('/assets/soundmap_loading.png') || Image.create(custom_path: '/assets/soundmap_loading.png') || nil # super reads attribute :image
  end

  def name
    return super || (self.audio && self.audio.name)
  end

  def make_soundmap_worker
    # basically just calls make_soundmap
    puts self.id
    EchonestWorker.perform_async(self.id)
    # self.make_soundmap
  end

  def make_soundmap
    # if (not self.image.blank? or self.image.custom_path == '/assets/soundmap-loading.png') or self.audio.blank?
    #   return
    # end
    puts '='*25 + "MAKE SOUNDMAP!!!!" + '='*25

    #self.soundmap_numbers = ([0]*5).map { rand*0.8+0.2 } # 5 random numbers
    s = get_soundmap_data(self.audio)
    self.soundmap_numbers = s[:numbers]
    col = s[:color] #hsv_to_rgb(rand, 0.55, 1)
    puts col
    image = Image.new
    image.file = generate_soundmap self.soundmap_numbers, col, filetype: "svg"
    image.save
    self.image = image
    #self.save
  end
end
