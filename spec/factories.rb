Factory.define :artist do |a|
	a.artistname { 'paulbunyan' }
end

Factory.define :event do |e|
	e.name { (0...50).map{ ('a'..'z').to_a[rand(26)] }.join }
	e.start_at { DateTime.now() }
	e.end_at { DateTime.now().since(3600) }
end