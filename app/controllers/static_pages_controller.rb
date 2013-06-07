class StaticPagesController < ApplicationController
  before_filter :set_user

  def set_user
    if cookies[:new_user]
      @user = User.find_by_id(cookies[:new_user])
    elsif session[:new_user]
      @user = session[:new_user]
    else
      @user = User.new
    end
    
    reset_session
  end
  
  def get_errors
    @current_errors = session[:current_errors]
    @current_errors = [] if @current_errors.blank?
  end
  
  def home
    @taglines = ["Music. Liberated.", "Music unleashed"]
    @tagline = @taglines[rand(@taglines.length)]
    
    set_user
    get_errors
    logger.debug "Static pages user: #{ @user }"
    # @has_new_user = session[:did_create_new_user]
  end

  def market
    # set_user
  end

  def team
    # set_user
  end
  
  def news
    # set_user
  end
  
  def careers
    # set_user
  end
  
  def contact
    # set_user
  end
  
  def beta
    # set_user
  end
  
  def terms
    # set_user
  end
end
