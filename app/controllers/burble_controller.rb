class BurbleController < ApplicationController
  def home
  end

  def feed
    loc = params[:location]
    # Render relevant items as JSON
    data = [
      { img_url: 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn1/s160x160/943566_492642090789944_356694603_a.jpg', text: 'PK' },
      { img_url: 'http://icons.iconarchive.com/icons/walrick/openphone/256/Calendar-icon.png', text: 'Concert tonight' },
      { img_url: 'https://cdn0.iconfinder.com/data/icons/cosmo-mobile/40/location_1-128.png', text: 'ThePianoGuys checked in at Five Guys' }
    ]
    respond_to do |format|
      # format.html # index.html.erb
      # format.xml  { render xml: @users}
      format.json { render json: data }
    end
  end
end
