module ControllersHelper
	def create_artist_events
		artist = Factory(:artist)
		e1 = Event.new(name: 'MusicFest', start_at: DateTime.new(2013, 6, 7, 16, 0, 0, '-4'), end_at: DateTime.new(2013, 6, 7, 19, 30, 0, '-4'))
		e1.creator = artist
		e1.save 
	end
end