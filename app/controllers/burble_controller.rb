class BurbleController < ApplicationController
  def home
  end

  def feed
  	loc = params[:location]
  	# Render relevant items as JSON
  end
end
