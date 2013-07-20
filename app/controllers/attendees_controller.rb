class AttendeesController < ApplicationController
  include LoginHelper;
  def join
    # Use currently signed in user, or user param if available
    # This way, we can send 'accept' links in emails and such
    u = current_user
    e = Event.find(params[:id])
    a = Attendee.find_by_user_id_and_event_id(u.id, e.id)
    a.status = params[:status]
    a.save
    respond_to do |format|  
      format.html { redirect_to(e) }  
      format.js   { render :nothing => true }  
    end
  end
end
