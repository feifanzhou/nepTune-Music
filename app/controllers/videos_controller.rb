class VideosController < ApplicationController
  def create
    vid = Video.new(params[:video])
    vid.is_temporary = true
    vid.save
    render text: '{"vid_id":' + vid.id.to_s + ',"vid_src":"' + vid.path + '"}';
  end
end
