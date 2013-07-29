# -*- coding: utf-8 -*-
class LoginController < ApplicationController
  include ApplicationHelper
  include LoginHelper
  include UsersHelper

  def destroy
    sign_out
    redirect_back
  end

  def login # Just displays login page
    # Save previous page
    session[:return_to] ||= request.referer
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
    if user.blank?
      user = User.find_by_email(fb_info[:email])
    end

    if user.blank?

      user_hash = { fname: fb_info[:first_name], lname: fb_info[:last_name], email: fb_info[:email], password: temporary_password, has_temp_password: true, facebook_id: fb_id }
      prms = { user: user_hash }
      results = create_user(prms)
      if results
        # redirect_to root_path
        # json_to_root
        json_to_path(session[:return_to] || root_path)
      # else
        # index_by: http://stackoverflow.com/a/412940/472768
        # status: http://stackoverflow.com/a/7238119/472768
        # render json: results.index_by(&:id), status: 500
      end
    else
      update_user_for_facebook_login(user, fb_info.merge(facebook_id: fb_id))
      save_user_to_cookie(user)
      # json_to_root
      json_to_path(session[:return_to] || root_path)
    end
  end

  def sign_in_user # Process and redirect
    # Check if id is filled out.
    # Users should not fill it out—it's hidden and says to leave blank
    # If it is filled out, then a script did it
    # Return an error
    if !params[:user][:id].blank?
      flash[:login_error] = "You filled in stuff that shouldn't be. Contact us for help."
      redirect_to login_path
    end
    user = User.find_by_email(params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      cookies[:current_user] = user.remember_token
      if user.has_temp_password
        redirect_to pwchange_path
      else
        # redirect_to root_path
        redirect_back
        # redirect_to session[:return_to]
      end
    else
      # Display error message, re-render login
      @user = User.new(params[:user].except(:fullAccountCreate, :artistname))
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
    # Duplicated code in sign_in_user
    # TODO: Refactor honeypot check code
    if !params[:user][:id].blank?
      flash[:login_error] = "You filled in stuff that shouldn't be. Contact us for help."
      redirect_to login_path
      return
    end
    sign_out
    # errors = create_user(params)
    user = create_user(params)

    if user.valid?
      user.isArtist ? redirect_to(artist_about_path(user.artists[0].route, edit: 1)) : redirect_to(root_path)
    else
      render "login"
    end
  end

  def reset_password
    email = params[:login][:email]
    user = User.find_by_email(email)
    if user.blank?
      flash[:reset_password_error] = "Couldn't find account with that email."
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
