include ApplicationHelper

module ArtistsHelper
  def get_artist_from_params
    if !params[:artist_route].blank?
      @artist = Artist.find_by_route(params[:artist_route])
      if @artist.blank?
        not_found
      end
    end
  end

  def route_from_artistname(name)
    regexp = %r{[^a-z0-9\-._~:#\[\]@!$&()*+,;]}
    name.strip.downcase.gsub(" ", "_").gsub(regexp, "")
  end
end
