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