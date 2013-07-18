class EventsController < ApplicationController
  include ApplicationHelper
  include LoginHelper

  before_filter :get_event, except: [:create, :update]
  before_filter :authenticate_editing, except: [:create]

  def show 
    @event = Event.find(params[:id])
    @curr_user = current_user
    # @attendee = Attendee.find_by_user_id_and_event_id(@curr_user.id, @event.id)
    @date_string = @event.display_time_string
    if !@curr_user.blank?
      creator = @event.creator
      bm = BandMember.find_by_user_id_and_artist_id(@curr_user.id, creator.id)
      @is_bm = (bm.blank?) ? false : true
    else
      @is_bm = false
    end
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
    artist = Artist.find_by_artistname(artistname)
    event.creator_id = artist.id
    event.save
    attendee = Attendee.create(artist: artist, status: :performing, event: event)
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
    if !params[:start_at].blank?
      date_format = "%m/%d/%Y %I:%M %p"
      new_date = DateTime.strptime(params[:start_at], date_format)
      event.start_at = new_date
    end
    if !params[:end_at].blank?
    	date_format = "%m/%d/%Y %I:%M %p"
      new_date = DateTime.strptime(params[:end_at], date_format)
      event.end_at = new_date
    end
    logger.debug("Updated event start at: #{ event.start_at }")
    logger.debug('===== Saving event =====')
    result = event.save
    logger.debug('===== Saving event succeeds') if result
    logger.debug('===== Saving event fails') unless result
    render json: { success: 1 }
  end

  private
  def get_event
    @event = Event.find(params[:id])
  end
  def can_edit
    curr_user = current_user
    artist = Artist.find(Event.find(params[:id]).creator_id)
    if curr_user.blank? || artist.blank?
      return false
    end
    bm = BandMember.find_by_user_id_and_artist_id(curr_user.id, artist.id)
    if bm.blank?
      return false
    end
    return true
  end
  def authenticate_editing
    @is_editing = false
    if params[:edit] == '0'
      cookies[:is_editing] = '0'
      redirect_to_current_page_without_params
      return
    end
    can_edit = can_edit()
    if can_edit && params[:edit].to_i == 1
      @is_editing = true
      cookies[:is_editing] = '1'
    end
    if can_edit && cookies[:is_editing] == '1'
      @is_editing = true
    end

    if !@is_editing
      cookies[:is_editing] = '0'
      redirect_to_current_page_without_params if !params[:edit].blank?
    end
  end
end
