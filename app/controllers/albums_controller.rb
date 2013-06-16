class AlbumsController < ApplicationController
  def new
  end

  def show
  	@album = Album.find_by_name(params[:album])
  end
end
