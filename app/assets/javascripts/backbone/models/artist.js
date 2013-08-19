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