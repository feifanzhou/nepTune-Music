# -*- coding: utf-8 -*-
class ArtistsController < ApplicationController
  include ArtistsHelper
  include LoginHelper
  before_filter :get_artist_from_params, only: [:show, :about, :music, :events, :burble, :fans]
  before_filter :get_current_user_status, only: [:show, :about, :music, :events, :burble, :fans]
  before_filter :authenticate_editing

  def show
    # TODO: Render 'about' if first visit, else render 'music'
    render 'music'
  end

  def about
    @contact_info = @artist.contact_info
  end

  def music
  end

  def events
    @events = @artist.events.sort_by! { |e| e.start_at }
  end

  def update_content
    case params[:location]
    when 'AboutGalleryCaption'
      # Is this secure? 
      # Does authenticate_editing prevent me from 
      # passing in any artist name and media id and modifying it?
      m_id = params[:mediaID].to_i
      m = Media.find(m_id)
      m.name = params[:newText]
      m.save
    when 'AboutStory'
      artist = Artist.find_by_artistname(params[:artistname])
      artist.story = sanitize(params[:newText])
      artist.save
    when 'AboutContactInfo'
      artist = Artist.find_by_artistname(params[:artistname])
      ci = artist.contact_info
      setter = params[:field] + '='   # Build setter method
      ci.send(setter, sanitize(params[:value]))   # http://stackoverflow.com/a/621193/472768
      ci.save
    end
    render json: { success: 1 }, status: 200
  end

  def remove_media
    loc = params[:location]
    if !loc.blank?
      remove_media_for_index_at_location(params[:media_index].to_i, loc)
      render json: { success: 1 }, status: 200
    else
      remove_media_with_id(params[:media_id])
      render json: { success: 1 }, status: 200
    end
  end

  private
  def authenticate_editing
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
    # Artist page should only be edited by members of the artist
    # TODO: Only allow editing artist page by designed member(s)
    curr_user = current_user
    artist = Artist.find_by_artistname(params[:artistname])
    bm = BandMember.find_by_user_id_and_artist_id(curr_user.id, artist.id)
    if bm.blank?
      redirect_to_current_page_without_params
    else
      @is_editing = true
    end
    # @is_editing = true unless bm.blank?
  end

  def get_current_user_status
    @current_user = current_user
    f = Follower.find_by_user_id_and_artist_id(@current_user.id, @artist.id)
    @is_following = !f.blank?
  end

  def remove_media_for_index_at_location(m_index, loc)
    # This code could probably be more efficient
    # Especially in pulling the artist info
    # Should pull only id—but code isn't working (undefined methods)
    # a_id = Artist.select(:id).find_by_artistname(params[:artistname]).limit(1)
    a_id = Artist.find_by_artistname(params[:artistname]).id
    m = Media.where(media_holder_id: a_id, location: loc.to_s, id: m_index)
    # FIXME: If m is nil, return 500 error, and handle in JS
    m.first.destroy  # Call destroy so we get callbacks such as before_destroy, where we can do undo
  end

  def remove_media_with_id(m_id)
    Media.find(m_id).destroy
  end

  def sanitize(s) 
    ActionView::Base.full_sanitizer.sanitize(s)
  end
end
