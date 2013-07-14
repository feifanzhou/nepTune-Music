class AudioController < ApplicationController
  def create
  	audio = Audio.new(params[:audio])
  	audio.is_temporary = true;
  	audio.save
  	# render json: { audio_id: audio.id }
  	render text: '{"audio_id":' + audio.id.to_s + '}<script type="text/javascript">window.onload = function() { parent.audio_target_loaded();}</script>'
  end
end
