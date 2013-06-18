module ArtistsHelper
	def get_artist_from_params
    if !params[:username].blank?
      @user = Artist.find_by_username(params[:username].downcase)
      if @user.blank?
        not_found
      end
    end
	end
end
