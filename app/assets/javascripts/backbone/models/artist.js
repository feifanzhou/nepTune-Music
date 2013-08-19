var Artist = Backbone.Model.extend({
	defaults: function() {
		return {
			artistname: ''
		};
	},
	paramRoot: 'artist',
	urlRoot: function() {
		if (this.isNew()) {
			// Create new artist URL
			return '/login/create';
		}
		else {
			return '/' + this.artistname;
		}
	}
});

// class NeptuneMusic.Models.Artist extends Backbone.Model
//   paramRoot: 'artist'

//   defaults:

// class NeptuneMusic.Collections.ArtistsCollection extends Backbone.Collection
//   model: NeptuneMusic.Models.Artist
//   url: '/artists'
