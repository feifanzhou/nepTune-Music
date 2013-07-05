class SongsController < ApplicationController
  def new
  	@song = Song.new
  end

  def show
  end
end
