var Artist = Backbone.Model.extend({
	defaults: function() {
		return {
			artistname: ''
		};
	},
	paramRoot: 'artist',
	urlRoot: '/'
});

// class NeptuneMusic.Models.Artist extends Backbone.Model
//   paramRoot: 'artist'

//   defaults:

// class NeptuneMusic.Collections.ArtistsCollection extends Backbone.Collection
//   model: NeptuneMusic.Models.Artist
//   url: '/artists'
