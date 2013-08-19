var FeedItem = Backbone.Model.extend({
	defaults: function() {
		return {
			links: [],
			text: '',
			type: 'unknown'
		};
	},
});

var Feed = Backbone.Collection.extend({
	model: FeedItem,
	url: '/burble/home'
});