FactoryGirl.define do
	factory :artist do |a|
		a.artistname { 'paulbunyan' }
		a.story { 'This is a sad story of a lonely lumberjack.'}
	end

	factory :contact_info do |c|
		c.email { 'paul@bunyan.com' }
		c.phone { '(401) 123-4567' }
		c.website { 'paulbunyan.com' }
	end

	factory :event do |e|
		e.name { (0...50).map{ ('a'..'z').to_a[rand(26)] }.join }
		e.start_at { DateTime.new(2013, 6, 7, 16, 0, 0, '-4') }
		e.end_at { DateTime.new(2013, 6, 7, 16, 0, 0, '-4').since(3600) }
	end
end