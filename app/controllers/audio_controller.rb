class AudioController < ApplicationController
  def create
  	audio = Audio.new(params[:audio])
  	audio.is_temporary = true;
  	audio.save
  	logger.debug("========= 2 audio: #{ audio }")
  	render json: { audio_id: audio.id }
  end
end
