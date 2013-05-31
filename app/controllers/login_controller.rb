class LoginController < ApplicationController
  include LoginHelper
  
  def destroy
    sign_out
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to root_path
  end
  
  def login # Just displays login page
    # Check if user just created a new account, and redirect as necessary
    if cookies[:current_user] && !cookies[:current_user].blank?
      redirect_to root_path
    end
    @login_error = flash[:login_error]
    logger.debug("Login error 2: #{ @login_error }")
  end
  
  def sign_in_user # Process and redirect
    user = User.find_by_email(params[:login][:email].downcase)
    if user && user.authenticate(params[:login][:password])
      cookies[:current_user] = user.remember_token
      redirect_to root_path
    else
      # Display error message, re-render login
      flash[:login_error] = "Email and password didn't match"
      logger.debug("Login error 1: #{ @login_error }")
      redirect_to login_path
    end
    # redirect_to root_path
  end
  
  def password_help
    @reset_error = flash[:reset_password_error]
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
    flash[:login_error] = "Check your email for a temporary password"
    redirect_to login_url
  end
  
end
