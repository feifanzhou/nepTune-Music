var AppRouter = Backbone.Router.extend({
	routes: {
		'': 'rootPath',
		':artistname': 'artistPath'
	}
});
var app_router = new AppRouter;
app_router.on('route:rootPath', function() {
	var wh = $(window).height();
	wh -= 100;
    $('#mapContainer').attr('style', ('height: ' + wh + 'px;'));
	// Load Google Maps
	var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&' +
      'callback=loadLocation';
    document.body.appendChild(script);

    var data = [
		{ img_url: 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn1/s160x160/943566_492642090789944_356694603_a.jpg', text: 'Hello 1' },
		{ img_url: 'http://icons.iconarchive.com/icons/walrick/openphone/256/Calendar-icon.png', text: 'Concert tonight' },
		{ img_url: 'https://cdn0.iconfinder.com/data/icons/cosmo-mobile/40/location_1-128.png', text: 'ThePianoGuys checked in at Five Guys' }
	];
    React.renderComponent (
    	BurbleBox({ data: data }),
    	document.getElementById('burbleBoxContainer')
    );

    React.renderComponent (
    	HomeBottomView({}),
    	document.getElementById('contentWrapper')
    );
});
app_router.on('route:artistPath', function(an) {
	var artist = new Artist({ artistname: an });
    React.renderComponent (
    	ArtistShowView({ model: artist }),
    	document.getElementById('container')
    );
});

// Start Backbone history a necessary step for bookmarkable URL's
Backbone.history.start();