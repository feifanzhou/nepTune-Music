class StaticPagesController < ApplicationController
  def home
    @taglines = ["Tapestry of sound", "Art of music", "Language of the soul", "Let's make music", "A world of music"]
    @tagline = @taglines[rand(@taglines.length)]
  end

  def market
  end

  def about
  end
end
