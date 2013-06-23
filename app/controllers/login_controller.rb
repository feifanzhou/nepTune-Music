class LoginController < ApplicationController
  include ApplicationHelper
  include LoginHelper

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
    errors = create_user(params)

    if @user.errors.blank?
      redirect_back
    else
      render "login"
    end
  end

  include UsersHelper
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
