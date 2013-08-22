var FeedItem = Backbone.Model.extend({
    defaults: function() {
        return {
            // links: [],
            // text: '',
            // type: 'unknown'
            icon_type: 'img',
            icon: '',
            text: '',
            top_date: '',
            bottom_date: '',
            url: '#'
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
