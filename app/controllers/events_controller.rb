class EventsController < ApplicationController
	include LoginHelper

	def show 
		@event = Event.find(params[:id])
		@curr_user = current_user
		# @attendee = Attendee.find_by_user_id_and_event_id(@curr_user.id, @event.id)
	end
end
