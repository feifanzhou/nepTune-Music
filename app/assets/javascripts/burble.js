// Geolocation API guide: http://diveintohtml5.info/geolocation.html
function loadLocation() {
  // Check if geolocation API is supported
  if (Modernizr.geolocation) {
    navigator.geolocation.getCurrentPosition(showMap, handleLocationError);
  }
  else {
    console.log('No location support');
  }
}

function showMap(position) {
  // var mapOptions = {
  //   center: new google.maps.LatLng(position.coords.latitude, position.coords.logitude),
  //   mapTypeControl: false,
  //   mapTypeId: google.maps.MapTypeId.ROADMAP,
  //   streetViewControl: false,
  //   zoom: 8,
  //   zoomControl: true
  // };

  // var map = new google.maps.Map(document.getElementById('mapContainer'),
  //     mapOptions);
  var mapOptions = {
    center: new google.maps.LatLng(position.coords.latitude, position.coords.longitude),
    mapTypeControl: false,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    panControl: false,
    scrollwheel: false,
    streetViewControl: false,
    zoom: 10,
    zoomControl: false
  };
  map = new google.maps.Map(document.getElementById('mapContainer'),
      mapOptions);
}

function handleLocationError(err) {
  // err.code 1: PERMISSION_DENIED
  // err.code 2: POSITION_UNAVAILABLE
  // err.code 3: TIMEOUT
}

$('body').on('click', '#contentGroupButtons .btn', function() {
  var viewID = '#' + $(this).data('show');
  $('.ContentSection').addClass('Hidden');
  $(viewID).removeClass('Hidden');
  // Scroll to bottom
  // http://stackoverflow.com/a/11715670/472768
  window.scrollTo(0, document.body.scrollHeight);

  // Load Twitter feed if necessary
  if ($(this).data('show') == 'resources')
    !function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+"://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");
});

$('body').on('click', '#scrollDownIndicator', function() {
  $("html, body").animate({ scrollTop: $(window).height() });
});