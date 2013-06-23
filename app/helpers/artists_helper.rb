include ApplicationHelper

module ArtistsHelper
	def get_artist_from_params
    if !params[:artistname].blank?
      @artist = Artist.find_by_artistname(params[:artistname].downcase)
      if @artist.blank?
        not_found
      end
    end
	end
end
