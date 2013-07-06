class SongsController < ApplicationController
  def new
  	@song = Song.new
  end

  def show
  end

  def create
  	song = Song.new
  	song.name = params[:song][:name]
  	audio = Audio.find(params[:song][:audio_id])
  	audio.is_temporary = false
  	audio.save
  	logger.debug("========== 0 audio: #{ audio }")
  	song.audio = audio
  	song.track_number = params[:song][:track_number] if !params[:song][:track_number].blank?
  	artist = Artist.find_by_artistname(params[:artistname])
  	song.artist = artist
  	album = Album.find_by_name_and_artist_id(params[:song][:album], artist.id)
  	if album.blank?
  		album = Album.new(name: params[:song][:album], artist: artist)
  	end
  	album_art = album.image
  	song.album = album
  	album_art ||= Image.find(params[:song][:album_art_id])
  	album.image = album_art unless album_art.blank?
  	album_art.is_temporary = false
  	album_art.save
  	song.save
  	album.save
  	# respond_to do |format|
  	# 	format.html { redirct_to artist_music_path(artist) }
  	# 	format.js { render json: { success: 1 } }
  	# end
  	render json: { success: 1 }
  end
end
