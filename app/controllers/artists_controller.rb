# -*- coding: utf-8 -*-
class ArtistsController < ApplicationController
  include ArtistsHelper
  include LoginHelper
  before_filter :get_artist_from_params, only: [:show, :about, :music, :events, :burble, :fans]
  before_filter :get_current_user_status, only: [:show, :about, :music, :events, :burble, :fans]
  before_filter :get_band_member, only: [:show, :about, :music, :events, :burble, :fans]
  before_filter :authenticate_editing
  before_filter :check_logged_in, only: [:update_content, :remove_media]
  before_filter :redirect_if_not_logged_in, only: [:update_content, :remove_media]
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
    artist = Artist.find_by_artistname(params[:artistname])
    obj_data = -1
    extra_data = -1
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
      artist.story = sanitize(params[:newText])
      artist.save
    when 'AboutContactInfo'
      ci = artist.contact_info
      setter = params[:field] + '='   # Build setter method
      ci.send(setter, sanitize(params[:value]))   # http://stackoverflow.com/a/621193/472768
      ci.save
    when 'AboutGalleryVideo'   # Add gallery video
      custom_path = params[:video_URL]
      caption = params[:caption]
      order = params[:order]
      ag = Video.create(name: caption, location: 'AboutGallery', custom_path: custom_path, collection_order: order, media_holder: artist)
      obj_data = ag.id
    when 'AboutGalleryImageUpload'    # Upload gallery image
      i = Image.create(location: 'AboutGallery', file: params[:select_image], media_holder: artist)
      obj_data = i.path
      extra_data = i.id
      sleep(1)
    when 'AboutGalleryImage'    # Add gallery image
      i = Image.find(params[:m_id])
      i.caption = params[:caption]
      i.collection_order = params[:order].to_i
      i.save
      obj_data = i.path
      extra_data = i.id
    when 'AboutGalleryImageRemove'
      m_id = params[:m_id]
      m = Media.find(m_id)
      m.destroy
    when 'ProfilePictureUpload'
      artist.avatar = params[:select_image]
      artist.save
      obj_data = artist.avatar.url
    end

    render json: { success: 1, obj_data: obj_data, extra_data: extra_data }, status: 200
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
  def can_edit
    curr_user = current_user
    artist = Artist.find_by_artistname(params[:artistname])
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
      redirect_to_current_page_without_params
      return
    end
    can_edit = can_edit()
    @is_editing = true if can_edit && params[:edit].to_i == 1
    @is_editing = true if can_edit && cookies[:is_editing] == '1'

    if !@is_editing
      cookies[:is_editing] = '0'
      redirect_to_current_page_without_params if !params[:edit].blank?
    end
  end

  def get_band_member
    @is_band_member = !@current_user.blank?
    bm = BandMember.find_by_user_id_and_artist_id(@current_user.id, @artist.id) if !@current_user.blank?
    @is_band_member = (bm.blank?) ? false : true
  end

  def get_current_user_status
    @current_user = current_user
    if @current_user.blank?
      @is_following = false
      return
    end
    # f = Following.find_by_user_id_and_artist_id(@current_user.id, @artist.id)
    f = Following.find_by_user_id_and_target_id(@current_user.id, @artist.id)
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

  def check_logged_in
    a_id = Artist.find_by_artistname(params[:artistname]).id
    bm = BandMember.find_by_user_id_and_artist_id(current_user.id, a_id)
    if bm.blank?
      redirect_to root_path
    end
  end

end
