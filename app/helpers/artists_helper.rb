include ApplicationHelper

module ArtistsHelper
  def get_artist_from_params(params)
    if !params[:artist_route].blank?
      @artist = Artist.find_by_route(params[:artist_route])
      return @artist
    else
      return nil
    end
  end

end
