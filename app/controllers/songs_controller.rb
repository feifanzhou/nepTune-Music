class SongsController < ApplicationController
  include LoginHelper

  before_filter :authenticate_editing, only: [:new, :create]

  def new
    @artist = Artist.find_by_artistname(params[:artistname])
    @song = Song.new
  end

  def show
    @artist = Artist.find_by_artistname(params[:artistname])
    @song = Song.find_by_id(params[:song])
  end

  def create
    puts "CREATE"
    song = Song.new
    song.name = params[:song][:name]
    audio = Audio.find(params[:song][:audio_id])
    audio.is_temporary = false
    audio.save
    song.audio = audio
    song.track_number = params[:song][:track_number] if !params[:song][:track_number].blank?
    artist = Artist.find_by_artistname(params[:artistname])
    song.artist = artist
    # TODO: Songs don't need to have an album
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
    #   format.html { redirct_to artist_music_path(artist) }
    #   format.js { render json: { success: 1 } }
    # end
    render json: { success: 1 }
  end

  def update
    song = Song.find(params[:id])
    if !params[:albumID].blank?
      shouldAdd = params[:shouldAdd].to_i
      album = Album.find(params[:albumID])
      if shouldAdd == 1
        song.album = album
      else
        song.album = nil
      end
    else
      if !params[:track_number].blank?
        song.track_number = params[:track_number]
      end
    end

    song.save
    render json: { success: 1 }
  end

  private
  def authenticate_editing
    artist = Artist.find_by_artistname(params[:artistname])
    curr_user = current_user
    if curr_user.blank? || artist.blank?
      redirect_to artist_main_path(artist.artistname)
      return
    end
    bm = BandMember.find_by_user_id_and_artist_id(curr_user.id, artist.id)
    redirect_to artist_main_path(artist.artistname) if bm.blank?
  end
end
