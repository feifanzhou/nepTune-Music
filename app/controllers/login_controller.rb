class LoginController < ApplicationController
  include ApplicationHelper
  include LoginHelper
  include UsersHelper

  def destroy
    sign_out
    redirect_back
  end

  def login # Just displays login page
    # Check if user just created a new account, and redirect as necessary
    if cookies[:current_user] && !cookies[:current_user].blank?
      redirect_to root_path
    end
    @login_error = flash[:login_error]
    @user = User.new
  end

  def fb_login # FB authentication has passed
    fb_info = params[:fb_info]
    fb_id = fb_info[:id]
    # Try to find user with FBID in database
    # If one exists, sign in and redirect
    # If one doesn't exist, create user
    user = User.find_by_facebook_id(fb_id)
    logger.debug("user by FBID: #{ user }")
    if user.blank?
      logger.debug('user blank')
      user_hash = { fname: fb_info[:first_name], lname: fb_info[:last_name], email: fb_info[:email], password: temporary_password, has_temp_password: true, facebook_id: fb_id }
      prms = { user: user_hash }
      logger.debug("Create user from FB prms: #{ prms }")
      results = create_user(prms)
      logger.debug("Create user results: #{ results }")
      if results
        save_user_to_cookie(user)
        # redirect_to root_path
        json_to_root
      # else
        # index_by: http://stackoverflow.com/a/412940/472768
        # status: http://stackoverflow.com/a/7238119/472768
        # render json: results.index_by(&:id), status: 500
      end
    else
      save_user_to_cookie(user)
      json_to_root
    end      
  end

  def sign_in_user # Process and redirect
    user = User.find_by_email(params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      cookies[:current_user] = user.remember_token
      if user.has_temp_password
        redirect_to pwchange_path
      else
        redirect_to root_path
      end
    else
      # Display error message, re-render login
      @user = User.new(params[:user].except(:fullAccountCreate))
      @login_error = "Email and password didn't match."
      render "login"
      #redirect_to login_path
    end
    # redirect_to root_path
  end

  def password_help
    @reset_error = flash[:reset_password_error]
  end

  def create_new_user
    sign_out
    # errors = create_user(params)
    results = create_user(params)

    # FIXME: Is @user ever defined
    # if @user.errors.blank?
    if results or results.blank?
      (params[:user][:isArtist].to_i == 1) ? redirect_to(artist_about_path(params[:user][:artistname], edit: 1)) : redirect_to(root_path)
    else
      render "login"
    end
  end

  def reset_password
    email = params[:login][:email]
    user = User.find_by_email(email)
    if user.blank?
      flash[:reset_password_error] = "Couldn't find account with that email."
      logger.debug("squid")
      redirect_to pwhelp_path
      return
    end
    user.password = temporary_password
    user.has_temp_password = true
    user.save
    # TODO: Send email with temp password
    flash[:login_error] = "Check your email for a temporary password."
    redirect_to login_url
  end

  def password_change # Renders view
    if !cookies[:current_user] or cookies[:current_user].blank?
      redirect_to login_path
    end
    @password_change_error = flash[:pw_change_error]
  end

  def change_password # Process and redirect
    old_pass = params[:login][:old_password]
    new_pass = params[:login][:password]
    if !cookies[:current_user] or cookies[:current_user].blank?
      flash[:login_error] = "Can't change password because you're not signed in."
      redirect_to login_path
      return
    end
    user = User.find_by_remember_token(cookies[:current_user])
    if user && user.authenticate(old_pass)
      user.password = new_pass
      user.has_temp_password = false
      user.save
      flash[:pw_change_error] = "Password changed successfully"
      redirect_back
    else
      flash[:pw_change_error] = "Current password doesn't match."
      redirect_to pwchange_path
      return
    end
  end

end
