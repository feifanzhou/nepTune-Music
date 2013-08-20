function rootPath() {
	var wh = $(window).height();
	wh -= 100;
    $('#mapContainer').attr('style', ('height: ' + wh + 'px;'));
    if ($('#mapsScript').length <= 0) {
    	// Load Google Maps 
    	var script = document.createElement('script');
        script.id = 'mapsScript';
        script.type = 'text/javascript';
        script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&' +
          'callback=loadLocation';
        document.body.appendChild(script);
    }

    var feed = new Feed;
    feed.fetch({
    	success: function(collection, response, options) {
    		React.renderComponent (
		    	BurbleBox({ data: collection }),
		    	document.getElementById('burbleBoxContainer')
		    );
    	}
    });

    React.renderComponent (
    	HomeBottomView({}),
    	document.getElementById('contentWrapper')
    );
}