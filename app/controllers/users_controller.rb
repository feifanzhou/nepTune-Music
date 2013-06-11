class UsersController < ApplicationController
  include ApplicationHelper
  include LoginHelper

  before_filter :get_user_from_params, only: [:show, :about, :music]
  
  def self.user=(u)
    @user = u
  end
  def self.user
    @user
  end

  def get_user_from_params
    if !params[:username].blank?
      logger.debug("Params username: #{ params[:username] }");
      @user = User.find_by_username(params[:username].downcase)
      if @user.blank?
        not_found
      end
    end
  end

  def show
    # TODO: Render 'about' if first visit, else render 'music'
    render 'music'
  end

  def about
  end

  def music
  end
  
  def new
  end
  
  def save_user_to_cookie(a_user)
    if !(a_user.has_temp_password)
      cookies[:current_user] = { value: a_user.remember_token, expires: 20.years.from_now }
    else
      cookies[:new_user] = { value: a_user.id, expires: 20.years.from_now }
    end
  end
  
  def is_profane_name?(name)
    terms = ['$', 'cunt', 'faggot', 'fuck', 'fuq', 'hoes', 'hoez', 'jamaal', 'jamal', 'jizz', 'nigger', 'nigga', 'suck', 'sucker', 'swag', 'swagg', 'swaq', 'swaqq', 'booger', 'poop']
    terms.each do |t|
      if name.downcase.include? t
        return true
      end
    end
    return false
  end
  
  def create
    sign_out
    input = params[:user]
    if input.blank?
      input = params[:login]
    end
    fullAccountCreate = input[:fullAccountCreate].to_i
    if fullAccountCreate and User.find_by_email(input[:email].downcase) # Signing up when email already exists
      flash[:login_error] = "You're already registered! Sign in below"
    end
    @user = User.new(input.except(:fullAccountCreate))
    should_save = true
    first_name = input[:fname]
    if (first_name) && is_profane_name?(first_name)
      @user.errors.add(:fname, "Not valid")
      logger.debug "Profane first name"
      should_save = false
    end
    last_name = input[:lname]
    if (last_name) && is_profane_name?(last_name)
      @user.errors.add(:lname, "Not valid")
      logger.debug "Profane last name"
      should_save = false
    end
    email = input[:email].downcase
    if (email) && is_profane_name?(email)
      @user.errors.add(:email, "Not valid")
      logger.debug "Profane email"
      should_save = false
    end
    if fullAccountCreate > 0
      password = input[:password]
      if password.length < 6
        @user.errors.add(:password, "Too short")
        should_save = false
      end
    end

    # TODO: Show message if signing up with an email that already exists
    session[:new_user] = @user
    logger.debug "Session user: #{ session[:new_user] }"
    if should_save && @user.save
      save_user_to_cookie(@user)
    elsif fullAccountCreate.blank? or fullAccountCreate == 0
      if (!email.blank?)  # If they enter an existing email, sign them in
        @user = User.find_by_email(email)
        if @user
          logger.debug "Found user for email: #{ email }"
          save_user_to_cookie(@user)
        end
      end
    end
    redirect_back
  end
  
  def make_beta_tester
    current_user = User.find_by_id(cookies[:new_user])
    current_user.willingToBetaTest = true
    current_user.save
    redirect_back
  end
end
