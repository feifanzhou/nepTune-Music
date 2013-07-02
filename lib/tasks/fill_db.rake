namespace :admin do
  desc "Reset DB and populate DB with test data"
  task :reset_and_fill_db => :environment do
    puts "Emptying database..."	# So old relations/ids/etc don't mess things up
    Rake::Task["db:reset"].invoke
    puts "Filling database..."
    Rake::Task["admin:fill_db"].invoke
  end

  desc "Populate DB with test data"
  task :fill_db => :environment do
    puts "Creating users..."	# Vanilla users
    u1 = User.create(fname: 'Ludwig', lname: 'van Beethoven', email: 'beethoven@me.com', isArtist: false, password: 'foobar')
    u2 = User.create(fname: 'Joseph', lname: 'Haydn', email: 'joe@haydn.com', isArtist: false, password: 'foobar')
    u3 = User.create(fname: 'Feifan', lname: 'Zhou', email: 'feifan@me.com', isArtist: false, password: 'foobar')
    u4 = User.create(fname: 'Pierre', lname: 'Karashchuk', email: 'pierre@getneptune.com', isArtist: false, password: 'foobar')
    u5 = User.create(fname: 'Drew', lname: 'Toma', email: 'dtoma@getneptune.com', isArtist: false, password: 'foobar')
    u6 = User.create(fname: 'Robert', lname: 'Robertson', email: 'robert@getneptune.com', isArtist: false, password: 'foobar')

    puts "Discovering artists..."
    jon = Artist.new(artistname: 'thepianoguys')
    jon.story = 'Paul Anderson owned a piano shop in St. George, Utah. '\
    'He met musician Jon Schmidt as the latter walked in to ask '\
    'if he could practice there for an upcoming concert. '\
    'Months later, Paul Anderson and Tel Stewart (then just for fun) '\
    'started making videos together of Jon Schmidt. It was not too long after '\
    'that they did their first collaboration with Jon Schmidt, Steven Sharp Nelson, '\
    'and Al van der Beek as the studio and music technician. After the five of them started collaborating '\
    'the group really started to take off, producing a music video each week and posting it to YouTube.'
    jon.save
    ci = ContactInfo.create(email: 'jon@thepianoguys.com',
                            phone: '(401) 123-4567', website: 'thepianoguys.com')
    jon.contact_info = ci
    bm = BandMember.create(artist_id: jon.id, user_id: u3.id)
    bm2 = BandMember.create(artist_id: jon.id, user_id: u4.id)
    ag1 = Video.new(name: 'Phillip Phillips - Home (Piano/Cello Cover)', location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/aF-Z1A0ujlg?rel=0', collection_order: 1)
    ag1.media_holder = jon
    ag1.save
    ag2 = Video.new(name: "Beethoven's 5 Secrets - OneRepublic (Cello/Orchestral Cover)", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/mJ_fkw5j-t0?rel=0', collection_order: 2)
    ag2.media_holder = jon
    ag2.save
    ag3 = Video.new(name: "Mission Impossible (Piano/Cello/Violin) ft. Lindsey Stirling", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/9p0BqUcQ7i0?rel=0', collection_order: 3)
    ag3.media_holder = jon
    ag3.save
    ag4 = Video.new(name: "Coldplay - Paradise (Peponi) African Style ft. Alex Boye", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/Cgovv8jWETM?rel=0', collection_order: 4)
    ag4.media_holder = jon
    ag4.save
    ag5 = Video.new(name: "Berlin", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/VcnzqKpFZ0I?rel=0', collection_order: 5)
    ag5.media_holder = jon
    ag5.save
    ag6 = Video.new(name: "Moonlight - Electric Cello", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/DRVvFYppU0w?rel=0', collection_order: 6)
    ag6.media_holder = jon
    ag6.save
    ag7 = Video.new(name: 'ThePianoGuys...before they were The Piano Guys', location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/noAoxGXHblw?rel=0', collection_order: 7)
    ag7.media_holder = jon
    ag7.save

    puts "Preparing albums..."	# Songs belong_to albums, so create albums first
    a1 = Album.create(name: 'Hits Volume 1')
    a1.artist = jon
    a1.save
    a2 = Album.create(name: 'Hits Volume 2')
    a2.artist = jon
    a2.save

    puts "Writing songs..."
    s1 = Song.create(name: 'Home')
    s1.artist = jon
    s1.save
    s2 = Song.create(name: 'Moonlight', track_number: 1)
    s2.artist = jon
    s2.album = a1
    s2.save
    s3 = Song.create(name: 'More Than Words', track_number: 3)
    s3.artist = jon
    s3.album = a1
    s3.save
    s4 = Song.create(name: 'All Of Me', track_number: 2)
    s4.artist = jon
    s4.album = a1
    s4.save
    s5 = Song.create(name: 'Peponi (Paradise)', track_number: 2)
    s5.artist = jon
    s5.album = a2
    s5.save
    s6 = Song.create(name: 'Titanium/Pavane', track_number: 1)
    s6.artist = jon
    s6.album = a2
    s6.save

    puts "Taking images..."	# Just album art and event photos, for now
    i1 = Image.create(caption: 'Hits Volume 1', custom_path: 'https://dl.dropboxusercontent.com/u/7828009/nepTuneTest/pg1.jpg', height: 600, width: 600)
    a1.image = i1
    i2 = Image.create(caption: 'Hits Volume 2', custom_path: 'https://dl.dropboxusercontent.com/u/7828009/nepTuneTest/pg2.jpg', height: 500, width: 500)
    a2.image = i2
    i3 = Image.create(caption: 'Soundmap', custom_path: 'https://dl.dropboxusercontent.com/u/7828009/nepTuneTest/sm1.png', height: 512, width: 512)
    s1.image = i3
    i4 = Image.create(caption: 'Listener', custom_path: 'http://fc00.deviantart.net/fs71/i/2010/132/a/f/Music_Girl_by_SauriBoombastic.png', height: 720, width: 900, is_primary: true)
    i5 = Image.create(caption: 'World Music', custom_path: 'http://msitvoiceiiit.files.wordpress.com/2013/02/world-music.jpg', height: 355, width: 380, is_primary: true)

    puts "Planning events..."
    e1 = Event.new(name: 'MusicFest', start_at: DateTime.new(2013, 6, 7, 16, 0, 0, '-4'), end_at: DateTime.new(2013, 6, 7, 19, 30, 0, '-4'))
    e1.creator = jon
    e1.images.push i4
    e1.save
    e2 = Event.new(name: '24 Hour Sesh', start_at: DateTime.new(2013, 6, 1, 10, 0, 0, '-4'), end_at: DateTime.new(2013, 6, 2, 10, 0, 0, '-4'))
    e2.creator = jon
    e2.images.push i5
    e2.save

    puts "Getting attendees..."
    at1 = Attendee.new(user: u1, event: e1)
    at1.status = :invited
    at1.save
    at2 = Attendee.new(user: u1, event: e2)
    at2.status = :going
    at2.save
    at3 = Attendee.new(user: u2, event: e1)
    at3.status = :invited
    at3.save
    at4 = Attendee.new(user: u2, event: e2)
    at4.status = :invited
    at4.save
    at5 = Attendee.new(user: u3, event: e1)
    at5.status = :invited
    at5.save
    at6 = Attendee.new(artist: jon, event: e1)
    at6.status = :performing
    at6.save
    at7 = Attendee.new(artist: jon, event: e2)
    at7.status = :going
    at7.save
    at8 = Attendee.new(user: u4, event: e1)
    at8.status = :maybe
    at8.save
    at9 = Attendee.new(user: u5, event: e1)
    at9.status = :maybe
    at9.save
    at10 = Attendee.new(user: u6, event: e1)
    at10.status = :going
    at10.save

    puts "Done!"
  end
end
