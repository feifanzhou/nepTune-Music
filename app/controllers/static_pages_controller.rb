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
  end
  
  def news
  end
  
  def jobs
  end
  
  def contact
  end
  
  def beta
  end
  
  def terms
  end
end
