class ImagesController < ApplicationController
  def create
  	img = Image.new(params[:image])
  	img.is_temporary = true
  	img.save
  	render json: { img_id: img.id, img_src: img.path }
  end
end
