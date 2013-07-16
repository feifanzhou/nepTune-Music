class EventsController < ApplicationController
	include ApplicationHelper
	include LoginHelper

	before_filter :get_event
	before_filter :authenticate_editing

	def show 
		@event = Event.find(params[:id])
		@curr_user = current_user
		# @attendee = Attendee.find_by_user_id_and_event_id(@curr_user.id, @event.id)
	end

	def create
		artistname = params[:event][:artistname]
		event = Event.new()
		event.name = params[:event][:name]
		event.location = params[:event][:location]
		event.details = params[:event][:details]
		date_format = "%m/%d/%Y %I:%M %p"
		event.start_at = DateTime.strptime(params[:event][:start_at], date_format)
		event.end_at = DateTime.strptime(params[:event][:end_at], date_format)
		event.creator_id = Artist.find_by_artistname(artistname).id;
		event.save
		logger.debug("=============== New event: #{ event }")
		redirect_to event
	end

	def update
		event = Event.find(params[:id])
		if !params[:name].blank?
			event.name = params[:name]
		end
		if !params[:location].blank?
			event.location = params[:location]
		end
		event.save
		render json: { success: 1 }
	end

	private
	def get_event
		@event = Event.find(params[:id])
	end
	def authenticate_editing
		@is_editing = false
    return if params[:edit].blank?  # Bail, don't bury: http://blog.wilshipley.com/2005/07/code-insults-mark-i.html
    # If edit param is anything other than 1, redirect to same page, without edit param
    if params[:edit].to_i != 1
      redirect_to_current_page_without_params
      return
    end

    if !is_logged_in
      redirect_to_current_page_without_params
      return
    end

    curr_user = current_user
    artist = Artist.find(@event.creator_id)
    if curr_user.blank? || artist.blank?
      redirect_to_current_page_without_params
    end
    bm = BandMember.find_by_user_id_and_artist_id(curr_user.id, artist.id)
    if bm.blank?
      redirect_to_current_page_without_params
    else
      @is_editing = true
    end
    # @is_editing = true unless bm.blank?
  end
end
