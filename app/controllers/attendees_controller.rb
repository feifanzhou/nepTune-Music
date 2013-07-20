class AttendeesController < ApplicationController
  include LoginHelper;

  def join
    # Use currently signed in user, or user param if available
    # This way, we can send 'accept' links in emails and such
    a = get_attendee
    a = Attendee.create(user: @user, event: @event)
    a.status = params[:status]
    a.save
    respond_to do |format|  
      format.html { redirect_to(@event) }  
      format.js   { render :nothing => true }  
    end
  end

  def leave
    a = get_attendee
    a.destroy
    respond_to do |format|
      format.html { redirect_to(@event) }
      format.js   { render :nothing => true }
    end
  end

  private
  def get_attendee
    @user = current_user
    @event = Event.find(params[:id])
    return Attendee.find_by_user_id_and_event_id(@user.id, @event.id)
  end
end
