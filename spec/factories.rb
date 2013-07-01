factory :artist do |a|
	a.artistname { 'paulbunyan' }
end

factory :event do |e|
	a.name { (0...50).map{ ('a'..'z').to_a[rand(26)] }.join }
	a.start_at { DateTime.now() }
	a.end_at { DateTime.now().since(3600) }