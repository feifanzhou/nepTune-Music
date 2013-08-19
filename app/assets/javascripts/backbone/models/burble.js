var FeedItem = Backbone.Model.extend({
	defaults: function() {
		return {
			// links: [],
			// text: '',
			// type: 'unknown'
			img_url: '',
			text: ''
		};
	},
	url: function() {
		return this.id ? '/burble/home/' + this.id : '/burble/home';
	}
});

var Feed = Backbone.Collection.extend({
	model: FeedItem,
	url: '/burble/home'
});