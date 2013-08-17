var AppRouter = Backbone.Router.extend({
	routes: {
		'': 'rootPath',
		':artistname': 'artistPath'
	}
});
var app_router = new AppRouter;
app_router.on('route:rootPath', function() {
	React.renderComponent(
		MainMapView({}),
		document.getElementById('container')
	);
	var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&' +
      'callback=loadLocation';
    document.body.appendChild(script);
});
app_router.on('route:artistPath', function(an) {
	var artist = new Artist({ artistname: an });
    React.renderComponent(
    	ArtistShowView({ model: artist }),
    	document.getElementById('container')
    );
});

// Start Backbone history a necessary step for bookmarkable URL's
Backbone.history.start();