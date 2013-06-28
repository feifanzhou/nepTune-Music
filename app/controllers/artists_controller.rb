class ArtistsController < ApplicationController
	include ArtistsHelper
  include LoginHelper
	before_filter :get_artist_from_params, only: [:show, :about, :music, :events, :burble, :fans]
  before_filter :authenticate_editing

	def show
    # TODO: Render 'about' if first visit, else render 'music'
    render 'music'
	end

	def about
	end

  def music
  end

  def events
    @events = @artist.events.sort_by! { |e| e.start_at }
  end

  private
  def authenticate_editing
    return if params[:edit].blank?  # Bail, don't bury: http://blog.wilshipley.com/2005/07/code-insults-mark-i.html
    # If edit param is anything other than 1, redirect to same page, without edit param
    if params[:edit].to_i != 1
      redirect_to request.fullpath.split("?")[0]  # http://stackoverflow.com/a/5266133/472768
      return
    end

    if !is_logged_in
      redirect_to login_path
      return
    end
    # Artist page should only be edited by members of the artist
    # TODO: Only allow editing artist page by designed member(s)
    curr_user = current_user
    artist = Artist.find_by_artistname(params[:artistname])
    bm = BandMember.find_by_user_id_and_artist_id(curr_user.id, artist.id)
    redirect_to login_path if bm.blank?
  end
end
