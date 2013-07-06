class AlbumsController < ApplicationController
  def new
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
