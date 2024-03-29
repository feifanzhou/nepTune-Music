# -*- coding: utf-8 -*-
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
      # song_for_artist_path(a.route, x.id)
      artist_music_path(a.route)
    end
  end

  def feed_data_for_location(location)
    events = Event.order('end_at ASC').select { |e| e.end_at > DateTime.now }
    burble_updates = Comment.sorted_for_location nil
    recent_songs = Song.order('created_at DESC').select { |s| s.created_at > 14.days.ago }

    all = events.concat(burble_updates).concat(recent_songs)
    now = DateTime.now
    all.sort_by! do |x|
      if x.kind_of? Event
        x.end_at.to_datetime - now
      elsif x.kind_of? Comment
        now - x.created_at.to_datetime
      elsif x.kind_of? Song
        now - x.created_at.to_datetime
      end
    end

    data = all.map do |e|
      if e.kind_of? Event
        puts '===== all map event ====='
        start_at, end_at = display_date(e.start_at).split(', ')
        #end_at = display_date(e.end_at)
        icon = 'http://icons.iconarchive.com/icons/walrick/openphone/256/Calendar-icon.png'
        header = e.name
        text = e.location
        url = route_to(e)
        performers_text = ""

        performers = Attendee.where(event_id: e.id, status: :performing)
        performers.map! { |p|
          x = User.find(p.user_id) if p.user_id
          x = Artist.find(p.artist_id) if p.artist_id
          x.display_name
        }
        if performers.length > 0
          t = 'Performer'
          if performers.length >= 2
            t = t.pluralize
          end
          if performers.length > 3
            performers.shuffle!
            performers[0..3]
            final = ", and more!"
          else
            final = ""
          end
          performers_text = "%s: %s" % [t, performers.join(', ')]
          performers_text += final
        end

      elsif e.kind_of? Comment
        puts '===== all map comment ====='
        user = User.find(e.user_id)
        icon = user.avatar.url
        start_at = distance_of_time_in_words_to_now(e.created_at) + ' ago'
        end_at = nil
        header = "#{user.display_name} says:"
        text = e.text[0..120]
        if e.text.length > 120
          text += '...'
        end
        url = route_to(e.commentable, comment: true)

      elsif e.kind_of? Song
        puts '===== all map song ====='
        icon = e.image.path
        header = e.name
        text = e.artist.display_name
        start_at = distance_of_time_in_words_to_now(e.created_at) + ' ago'
        end_at = nil
        url = route_to(e)
        performers_text = nil
      end
      {
        icon_type: 'img',
        icon: icon,
        header: header,
        text: text,
        top_date: start_at,
        bottom_date: end_at,
        url: url,
        performers: performers_text
      }
    end

    return data
  end

end
