module ControllersHelper
	def create_artist_event(artist)
		e1 = Factory(:event)
		e1.creator = artist
		e1.save
		return e1
	end
end