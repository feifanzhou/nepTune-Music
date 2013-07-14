class ImagesController < ApplicationController
  def create
  	img = Image.new(params[:image])
  	img.is_temporary = true
  	img.save
  	# render json: { img_id: img.id, img_src: img.path }
  	render text: '{"img_id":' + img.id.to_s + ',"img_src":"' + img.path + '"}<script type="text/javascript">window.onload = function() { parent.image_target_loaded();}</script>'
  end
end
