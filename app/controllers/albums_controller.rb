class AlbumsController < ApplicationController
  include ArtistsHelper
  def new
    @album = Album.new
    @artist = Artist.find_by_artistname(params[:artistname])
    @songs = @artist.songs.order('updated_at DESC')
  end

  def create
    # TODO: Check existing albums to see if modifying existing album first
    album = Album.new
    album.name = params[:album][:name]
    album.year = params[:album][:year].to_i
    album.artist = Artist.find_by_route(params[:album][:artist_route])
    if (params[:album][:art_id].blank?)
      album.image = Image.default_album_image
    else
      album.image = Image.find(params[:album][:art_id])
    end
    album.save
    render json: { album_id: album.id, success: 1 }
  end

  def show
    @album = Album.find_by_name(params[:album])
    @artist = get_artist_from_params(params)
  end

  def album_name_suggestions
    results = Album.where("name ILIKE ?", params[:input] + '%')  # ILIKE is case-insensitive compare
    names = results.map(&:name)
    paths = results.map(&:image).map(&:path)
    # results = Album.find :all, select: 'id, DISTINCT name', conditions: [ "(name LIKE ?)", '%' + params[:input] + '%']
    render json: { names: names,  paths: paths }
  end
end
