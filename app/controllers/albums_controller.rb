class AlbumsController < ApplicationController
  def new
  end

  def show
  	@album = Album.find_by_name(params[:album])
  end

  def album_name_suggestions
  	results = Album.where("name ILIKE ?", params[:input] + '%').map(&:name)
  	logger.debug("============= results: #{ results }")
  	# results = Album.find :all, select: 'id, DISTINCT name', conditions: [ "(name LIKE ?)", '%' + params[:input] + '%']
  	render json: { results: results }
  end
end
