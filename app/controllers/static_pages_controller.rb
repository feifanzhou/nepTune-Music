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
  
  def home
    @taglines = ["Let's make music", "A world of music"]
    @tagline = @taglines[rand(@taglines.length)]
    
    # set_user
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
