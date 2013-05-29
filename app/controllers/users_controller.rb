class UsersController < ApplicationController
  include LoginHelper
  
  @user
  
  def self.user=(u)
    @user = u
  end
  def self.user
    @user
  end
  
  def show
  end
  
  def new
  end
  
  def save_user_to_cookie(a_user)
    cookies[:new_user] = { value: a_user.id, expires: 20.years.from_now }
  end
  
  def redirect_back
    redirect_to :back
    rescue ActionController::RedirectBackError
      redirect_to root_path
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
    if !input || !defined?(input)
      input = params[:login]
    end
    @user = User.new(input)
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
    email = input[:email]
    if (email) && is_profane_name?(email)
      @user.errors.add(:email, "Not valid")
      logger.debug "Profane email"
      should_save = false
    end
    password = input[:password]
    if (password) && (password.length < 6)
      @user.errors.add[:password, "Too short"]
      logger.debug "Password too short"
      should_save = false
    end

    session[:new_user] = @user
    logger.debug "Session user: #{ session[:new_user] }"
    if should_save && @user.save
      save_user_to_cookie(@user)
    else
      if (email)  # If they enter an existing email, sign them in
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
