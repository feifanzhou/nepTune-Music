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

    var feed = new Feed;
    feed.fetch({
    	success: function(collection, response, options) {
    		React.renderComponent (
		    	BurbleBox({ data: collection }),
		    	document.getElementById('burbleBoxContainer')
		    );
    	}
    });

    // var feedItem = new FeedItem({
    // 	img_url: 'https://fbcdn-profile-a.akamaihd.net/hprofile-ak-prn1/s160x160/943566_492642090789944_356694603_a.jpg',
    // 	text: 'Hello'
    // });
    // var feedItem = feed.at(1);
    // console.log('feedItem: ' + JSON.stringify(feedItem, null, 4));

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