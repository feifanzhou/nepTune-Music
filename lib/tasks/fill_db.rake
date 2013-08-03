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
    jon = Artist.new(artistname: 'The Piano Guys', route: 'thepianoguys')
    jon.story = """Paul Anderson owned a piano shop in St. George, Utah.
He met musician Jon Schmidt as the latter walked in to ask
if he could practice there for an upcoming concert.
Months later, Paul Anderson and Tel Stewart (then just for fun)
started making videos together of Jon Schmidt. It was not too long after
that they did their first collaboration with Jon Schmidt, Steven Sharp Nelson,
and Al van der Beek as the studio and music technician. After the five of them started collaborating
the group really started to take off, producing a music video each week and posting it to YouTube."""
    jon.avatar = URI.parse('https://dl.dropboxusercontent.com/u/16963685/chirku/pianoguys.jpg')
    jon.save
    ci = ContactInfo.create(email: 'jon@thepianoguys.com',
                            phone: '(401) 123-4567', website: 'thepianoguys.com')
    jon.contact_info = ci
    jon.save

    bm = BandMember.create(artist_id: jon.id, user_id: u3.id)
    bm2 = BandMember.create(artist_id: jon.id, user_id: u4.id)

    ag1 = Video.create(name: 'Phillip Phillips - Home (Piano/Cello Cover)', location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/aF-Z1A0ujlg?rel=0', collection_order: 1, media_holder: jon)
    ag2 = Video.create(name: "Beethoven's 5 Secrets - OneRepublic (Cello/Orchestral Cover)", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/mJ_fkw5j-t0?rel=0', collection_order: 2, media_holder: jon)

    #disable for faster testing
    # ag3 = Video.create(name: "Mission Impossible (Piano/Cello/Violin) ft. Lindsey Stirling", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/9p0BqUcQ7i0?rel=0', collection_order: 3, media_holder: jon)
    # ag4 = Video.create(name: "Coldplay - Paradise (Peponi) African Style ft. Alex Boye", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/Cgovv8jWETM?rel=0', collection_order: 4, media_holder: jon)
    # ag5 = Video.create(name: "Berlin", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/VcnzqKpFZ0I?rel=0', collection_order: 5, media_holder: jon)
    # ag6 = Video.create(name: "Moonlight - Electric Cello", location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/DRVvFYppU0w?rel=0', collection_order: 6, media_holder: jon)
    # ag7 = Video.create(name: 'ThePianoGuys...before they were The Piano Guys', location: 'AboutGallery', custom_path: 'http://www.youtube.com/embed/noAoxGXHblw?rel=0', collection_order: 7, media_holder: jon)

    puts "Taking images..."	# Just album art and event photos, for now
    i1 = Image.create(caption: 'Hits Volume 1', custom_path: 'https://dl.dropboxusercontent.com/u/7828009/nepTuneTest/pg1.jpg', height: 600, width: 600)
    i2 = Image.create(caption: 'Hits Volume 2', custom_path: 'https://dl.dropboxusercontent.com/u/7828009/nepTuneTest/pg2.jpg', height: 500, width: 500)
    i3 = Image.create(caption: 'Soundmap', custom_path: 'https://dl.dropboxusercontent.com/u/7828009/nepTuneTest/sm1.png', height: 512, width: 512)
    i4 = Image.create(caption: 'Listener', custom_path: 'http://fc00.deviantart.net/fs71/i/2010/132/a/f/Music_Girl_by_SauriBoombastic.png', height: 720, width: 900, is_primary: true)
    i5 = Image.create(caption: 'World Music', custom_path: 'http://msitvoiceiiit.files.wordpress.com/2013/02/world-music.jpg', height: 355, width: 380, is_primary: true)

    puts "Preparing albums..."	# Songs belong_to albums, so create albums first
    a1 = Album.create(name: 'Hits Volume 1', image: i1, artist: jon, year: 2011)
    a2 = Album.create(name: 'Hits Volume 2', image: i2, artist: jon, year: 2012)

    puts "Writing songs..."
    s1 = Song.create(name: 'Bring Him Home', artist: jon, album: a1, #image: i3,
                     audio: Audio.create(custom_path: 'https://dl.dropboxusercontent.com/u/16963685/chirku/The%20piano%20guys/8.%20Bring%20Him%20Home%20%28Les%20Miserables%29.mp3'))
    s2 = Song.create(name: 'Moonlight', track_number: 1, artist: jon, album: a1,
                     #image: Image.create(custom_path: 'https://dl.dropboxusercontent.com/u/16963685/chirku/test2.png'),
                     audio: Audio.create(custom_path: 'https://dl.dropboxusercontent.com/u/16963685/chirku/The%20piano%20guys/2.%20Moonlight.mp3'))
    s3 = Song.create(name: 'More Than Words', track_number: 3, artist: jon, album: a1,
                     audio: Audio.create(custom_path: 'https://dl.dropboxusercontent.com/u/16963685/chirku/The%20piano%20guys/12.%20More%20Than%20Words.mp3'))
    s4 = Song.create(name: 'All Of Me', track_number: 2, artist: jon, album: a1,
                     audio: Audio.create(custom_path: 'https://dl.dropboxusercontent.com/u/16963685/chirku/The%20piano%20guys/11.%20All%20Of%20Me.mp3'))
    s5 = Song.create(name: 'Peponi (Paradise)', track_number: 2, artist: jon, album: a2,
                     audio: Audio.create(custom_path: 'https://dl.dropboxusercontent.com/u/16963685/chirku/peponi.mp3'))
    s6 = Song.create(name: 'Titanium/Pavane', track_number: 1, artist: jon, album: a2,
                     audio: Audio.create(custom_path: 'https://dl.dropboxusercontent.com/u/16963685/chirku/titanium.mp3'))
    s6 = Song.create(name: 'Next Stop Everywhere', artist: jon,
                     image: Image.create(custom_path: 'https://dl.dropboxusercontent.com/u/16963685/tardis.jpg'),
                     audio: Audio.create(custom_path: 'https://dl.dropboxusercontent.com/u/16963685/dr_who_next_stop_everywhere.mp3'))

    puts "Planning events..."
    e1 = Event.new(name: 'MusicFest', start_at: DateTime.new(2013, 7, 28, 16, 0, 0, '-4'), end_at: DateTime.new(2013, 7, 28, 20, 0, 0, '-4'))
    e1.creator = jon
    e1.images.push i4
    e1.save

    e2 = Event.new(name: 'Jam Sesh', start_at: DateTime.new(2013, 7, 31, 10, 0, 0, '-4'), end_at: DateTime.new(2013, 7, 31, 13, 0, 0, '-4'))
    e2.creator = jon
    e2.images.push i5
    e2.save

    puts "Getting attendees..."
    at1 = Attendee.create(user: u1, event: e1, status: :invited)
    at2 = Attendee.create(user: u1, event: e2, status: :going)
    at3 = Attendee.create(user: u2, event: e1, status: :invited)
    at4 = Attendee.create(user: u2, event: e2, status: :invited)
    at5 = Attendee.create(user: u3, event: e1, status: :invited)
    at6 = Attendee.create(artist: jon, event: e1, status: :performing)
    at7 = Attendee.create(artist: jon, event: e2, status: :going)
    at8 = Attendee.create(user: u4, event: e1, status: :maybe)
    at9 = Attendee.create(user: u5, event: e1, status: :maybe)
    at10 = Attendee.create(user: u6, event: e1, status: :going)

    puts "Writing comments..."
    c1 = Comment.create(text: "Why, this rivals some of my own work!", commenter: u1, artists: [jon])
    c2 = Comment.create(text: "AMAZING!", commenter: u6, artists: [jon])
    c3 = Comment.create(text: "Waka waka waka", commenter: u4, artists: [jon])
    c4 = Comment.create(text: "Thanks for the feedback! It really means a lot coming from you!", commenter: u3, parent: c1, artists: [jon])
    c5 = Comment.create(text: "No problem!", commenter: u1, parent: c4, artists: [jon])
    c6 = Comment.create(text: "Waka.", commenter: u2, parent: c3, artists: [jon])
    c7 = Comment.create(text: "I second this.", commenter: u2, parent: c1, artists: [jon])

    puts "Done!"
  end
end
