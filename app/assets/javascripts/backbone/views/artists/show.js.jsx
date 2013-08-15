/** @jsx React.DOM */
ArtistShowView = React.createBackboneClass({
	render: function() {
		return (<div>{ this.getModel().get('artistname') }</div>);
	}
});