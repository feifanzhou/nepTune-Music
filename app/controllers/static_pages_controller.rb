class StaticPagesController < ApplicationController
  def home
    @taglines = ["A tapestry of sound", "The art of music", "Language of the soul", "Let's make music", "A world of music"]
    @tagline = @taglines[rand(@taglines.length)]
    
    @user = User.new
  end

  def market
    @user = User.new
  end

  def team
    @user = User.new
  end
  
  def news
    @user = User.new
  end
  
  def jobs
    @user = User.new
  end
  
  def contact
    @user = User.new
  end
  
  def beta
    @user = User.new
  end
  
  def terms
    @user = User.new
  end
end
