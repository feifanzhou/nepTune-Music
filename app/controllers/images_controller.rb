class ImagesController < ApplicationController
  def create
  	img = Image.new(params[:image])
  	img.is_temporary = true
  	img.save
  	logger.debug("============== 1 img: #{ img }")
  	render json: { img_id: img.id, img_src: img.path }
  end
end
