class SongsController < ApplicationController
  def new
  	@song = Song.new
  end

  def show
  end

  def create
  	song = Song.new
  	song.name = params[:song][:name]
  	song.track_number = params[:song][:track_number] if !params[:song][:track_number].blank?
  	artist = Artist.find_by_artistname(params[:artistname])
  	logger.debug("============= 0 artist: #{ artist }, #{ artist.id }")
  	song.artist = artist
  	album = Album.find_by_name_and_artist_id(params[:song][:album], artist.id)
  	if album.blank?
  		album = Album.new(name: params[:song][:name], artist: artist)
  	end
  	logger.debug("============= 1 album: #{ album }, #{ album.id }")
  	album_art = album.image
  	logger.debug("============= 2 album_art: #{ album_art }")
  	song.album = album
  	album_art ||= Image.find(params[:album_art_id])
  	album.image = album_art unless album_art.blank?
  	album_art.is_temporary = false
  	aas = album_art.save
  	logger.debug("============= 3 album_art save: #{ aas }")
  	ss = song.save
  	logger.debug("============= 4 song save: #{ ss }")
  	as = album.save
  	logger.debug("============= 5 album save: #{ as }")
  	# respond_to do |format|
  	# 	format.html { redirct_to artist_music_path(artist) }
  	# 	format.js { render json: { success: 1 } }
  	# end
  	render json: { success: 1 }
  end
end
