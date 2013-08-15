var AppRouter = Backbone.Router.extend({
	routes: {
		':artistname': 'artistRoute'
	}
});
var app_router = new AppRouter;
app_router.on('route:artistRoute', function(an) {
	var artist = new Artist({ artistname: an });
    React.renderComponent(
    	ArtistShowView({ model: artist }),
    	document.getElementById('container')
    );
})

// Start Backbone history a necessary step for bookmarkable URL's
Backbone.history.start();