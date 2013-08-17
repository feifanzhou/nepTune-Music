/** @jsx React.DOM */
ArtistShowView = React.createBackboneClass({
  render: function() {
    return (<div>{ this.getModel().get('artistname') }</div>);
  }
});

BurbleSearch = React.createBackboneClass({
  render: function() {
    return (<form id='discoverForm'><input type='text' id='discoverBox' placeholder='Search for artists, events, and music' /></form>);
  }
});
BurbleMainFeedItem = React.createBackboneClass({
  render: function() {
    return(
      <li class='BurbleMainFeedItem'>
        <img class='BurbleFeedProfile' height='40' width='40' src={ this.props.img_url } />
        { this.props.children }
      </li>
    );
  }
});
BurbleMainFeed = React.createBackboneClass({
  render: function() {
    var feedNodes = this.props.data.map(function(item) {
      return <BurbleMainFeedItem img_url={ item.img_url }>{ item.text }</BurbleMainFeedItem>
    });
    return (
      <ol id='mainFeed'>
        { feedNodes }
      </ol>
    );
  }
});
BurbleBox = React.createBackboneClass({
  render: function() {
    return (
      <div id='burbleBox'>
        <BurbleSearch />
        <BurbleMainFeed data={ this.props.data } />
      </div>
    );
  }
});

HomeBottomView = React.createBackboneClass({
  render: function() {
    return (
      <div id='content'>
        <p class='Icon' id='scrollDownIndicator'>&#59397;</p>
        <div class='btn-group' id='contentGroupButtons' data-toggle="buttons-radio">
          <button class='btn'>Beta</button>
          <button class='btn'>Resources</button>
          <button class='btn'>Mobile</button>
        </div>
      </div>
    )
  }
})