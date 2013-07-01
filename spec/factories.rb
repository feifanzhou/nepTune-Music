Factory.define :artist do |a|
	a.artistname { 'paulbunyan' }
end

Factory.define :event do |e|
	e.name { (0...50).map{ ('a'..'z').to_a[rand(26)] }.join }
	e.start_at { DateTime.new(2013, 6, 7, 16, 0, 0, '-4') }
	e.end_at { DateTime.new(2013, 6, 7, 16, 0, 0, '-4').since(3600) }
end