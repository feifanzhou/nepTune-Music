module BurbleHelper

  include ActionView::Helpers::DateHelper

  def route_to(x, opts={})
    comment = opts[:comment] || false
    #TODO: add more kinds
    if x.kind_of? Event
      event_path(x.id)
    elsif x.kind_of? Artist
      if comment
        artist_burble_path(x.route)
      else
        artist_main_path(x.route)
      end
    elsif x.kind_of? Song
      a = x.artist
      song_for_artist_path(a.route, x.id)
    end
  end

  def feed_data_for_location(location)
    events = Event.order('end_at ASC').select { |e| e.end_at > DateTime.now}
    burble_updates = Comment.sorted_for_location nil

    all = events.concat(burble_updates)
    now = DateTime.now
    all.sort_by! do |x|
      if x.kind_of? Event
        x.end_at.to_datetime - now
      elsif x.kind_of? Comment
        now - x.created_at.to_datetime
      end
    end

    data = all.map do |e|
      if e.kind_of? Event
        start_at, end_at = display_date(e.start_at).split(', ')
        #end_at = display_date(e.end_at)
        icon = 'http://icons.iconarchive.com/icons/walrick/openphone/256/Calendar-icon.png'
        header = e.name
        text = e.location
        url = route_to(e)
      elsif e.kind_of? Comment
        user = User.find(e.user_id)
        icon = user.avatar.url
        start_at = distance_of_time_in_words_to_now(e.created_at) + ' ago'
        end_at = nil
        header = "#{user.display_name} says:"
        text = e.text
        url = route_to(e.commentable, comment: true)
      end
      {
        icon_type: 'img',
        icon: icon,
        header: header,
        text: text,
        top_date: start_at,
        bottom_date: end_at,
        url: url
      }


    end

  end

end
