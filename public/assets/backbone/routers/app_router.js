var AppRouter=Backbone.Router.extend({routes:{"":"rootPath",":artistname":"artistPath"}}),app_router=new AppRouter;app_router.on("route:rootPath",function(){rootPath()}),app_router.on("route:artistPath",function(t){var e=new Artist({artistname:t});React.renderComponent(ArtistShowView({model:e}),document.getElementById("container"))}),Backbone.history.start();