class ArtistsController < ApplicationController
	include ArtistsHelper
	before_filter :get_artist_from_params, only: [:show, :about, :music, :events, :burble, :fans]

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
end
