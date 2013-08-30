var FeedItem = Backbone.Model.extend({
    defaults: function() {
        return {
            // links: [],
            // text: '',
            // type: 'unknown'
            icon_type: 'img',
            icon: '',
            header: '',
            text: '',
            top_date: '',
            bottom_date: '',
            url: '#',
            performers: ''
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
