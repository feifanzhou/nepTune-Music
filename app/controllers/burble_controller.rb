class BurbleController < ApplicationController

  include EventsHelper
  include BurbleHelper

  def home
  end

  def feed
    loc = params[:location]

    data = feed_data_for_location(loc)

    # data = data[1..5]

    # data = [
    #   { icon: 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn1/s160x160/943566_492642090789944_356694603_a.jpg', text: 'PK' },
    #   { icon: 'http://icons.iconarchive.com/icons/walrick/openphone/256/Calendar-icon.png', text: 'Concert tonight' },
    #   { icon: 'https://cdn0.iconfinder.com/data/icons/cosmo-mobile/40/location_1-128.png', text: 'ThePianoGuys checked in at Five Guys' }
    # ]

    # Render relevant items as JSON
    respond_to do |format|
      # format.html # index.html.erb
      # format.xml  { render xml: @users}1
      format.json { render json: data }
    end
  end
end
