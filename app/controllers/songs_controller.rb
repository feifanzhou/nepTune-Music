class SongsController < ApplicationController
  include LoginHelper
  include ArtistsHelper

  before_filter :authenticate_editing, only: [:new, :show, :create]

  def new
    @artist = get_artist_from_params(params)
    @song = Song.new
  end

  def show
    @artist = get_artist_from_params(params)
    @song = Song.find_by_id(params[:song])
    @comments = Comment.sorted_for_commentable(@song)
  end

  def create
    puts "===== CREATE SONG ====="
    song = Song.new
    song.name = params[:song_name]
    audio = Audio.find(params[:song_audio_id])
    audio.is_temporary = false
    audio.save
    song.audio = audio
    song.track_number = params[:song_track_number] if !params[:song_track_number].blank?
    artist = get_artist_from_params(params)
    song.artist = artist

    # if not params[:song][:album].blank?
    #   album = Album.find_by_name_and_artist_id(params[:song][:album], artist.id)
    #   if album.blank?
    #     album = Album.new(name: params[:song][:album], artist: artist)
    #   end
    #   album_art = album.image
    #   song.album = album
    #   album_art ||= Image.find(params[:song][:album_art_id])
    #   album.image = album_art unless album_art.blank?
    #   album_art.is_temporary = false
    #   album_art.save
    #       album.save
    # end

    # if not params[:song][:album_art_id].blank?
    #   song.image = Image.find(params[:song][:album_art_id])
    # end

    song.save
    #
    # respond_to do |format|
    #   format.html { redirct_to artist_music_path(artist) }
    #   format.js { render json: { success: 1 } }
    # end
    render json: { success: 1, song_name: song.name, song_id: song.id }
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
    artist = get_artist_from_params(params)
    @user = current_user
    if @user.blank? || artist.blank?
      redirect_to artist_main_path(artist.route)
      return
    end
    bm = BandMember.find_by_user_id_and_artist_id(@user.id, artist.id)
    puts "===== song user (1): #{ @user }"
    redirect_to artist_main_path(artist.route) if bm.blank?
  end
end
