class AlbumsController < ApplicationController
  def new
    @album = Album.new
    @artist = Artist.find_by_artistname(params[:artistname])
  end

  def create
    # TODO: Check existing albums to see if modifying existing album first
    album = Album.new
    album.name = params[:album][:name]
    album.year = params[:album][:year].to_i
    album.artist = Artist.find_by_artistname(params[:album][:artistname])
    if (params[:album][:art_id].blank?)
      album.image = Image.default_album_image
    else
      album.image = Image.find(params[:album][:art_id])
    end
    album.save
    render json: { success: 1 }
  end

  def show
  	@album = Album.find_by_name(params[:album])
  end

  def album_name_suggestions
  	results = Album.where("name ILIKE ?", params[:input] + '%')
    names = results.map(&:name)
    paths = results.map(&:image).map(&:path)
  	# results = Album.find :all, select: 'id, DISTINCT name', conditions: [ "(name LIKE ?)", '%' + params[:input] + '%']
  	render json: { names: names,  paths: paths }
  end
end
