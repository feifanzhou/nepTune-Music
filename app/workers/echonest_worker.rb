class EchonestWorker
  include Sidekiq::Worker

  def perform(song_id)
  	puts "HELLO HELLO"
  	puts song_id
    song = Song.find_by_id(song_id)
    if song.blank?
      return
    else
      song.make_soundmap
    end
  end

end
