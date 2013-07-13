class AudioController < ApplicationController
  def create
  	audio = Audio.new(params[:audio])
  	audio.is_temporary = true;
  	audio.save
  	render json: { audio_id: audio.id }
  end
end
