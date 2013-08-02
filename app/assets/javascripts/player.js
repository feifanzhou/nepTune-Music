soundManager.reset();
soundManager.setup({
  url: '/swf/',
  flashVersion: 9, // optional: shiny features (default = 8)
  // optional: ignore Flash where possible, use 100% HTML5 mode
  preferFlash: false,
  onready: function() {
    //playStuff()
  },
  ontimeout: function() {
    // Hrmm, SM2 could not start. Missing SWF? Flash blocked? Show an error, etc.?
    // alert('broken');
  }
});

var playerProgress;
function createPlayerProgress() {
  console.log('Create player progress');
  playerProgress = new CircularProgress({
    radius: 48,
    strokeStyle: 'white',
    lineCap: 'round',
    lineWidth: 8
  });
  // document.getElementById('songControls').appendChild(playerProgress.el);
  $('.SongControls').first().append(playerProgress.el);
  playerProgress.update(0);
}

var currentSound = false;

var playingID = false;
var currentID = false;

var songUIID;
function songControlsID() {
  return '#songControls' + songUIID;
}

function updateBarPlaying() {
  if(currentSound) {
    var pgp = 100 * currentSound.position / currentSound.durationEstimate;
    $('.position').css('width', pgp + '%');
    if (playingID == currentID) {
      playerProgress.update(pgp);
    }
  }
}

function updateBarLoading() {
  if(currentSound) {
    $('.loading').css('width', 100*currentSound.duration/currentSound.durationEstimate + '%');
  }
}

function changePlayButton(name) {
  function n() {
    $('#playPauseBtn').text(name);
    if (name == 'Pause') {
      $(songControlsID()).find('.PauseIcon').first().css('display', 'inline-block');
      $(songControlsID()).find('.PlayIcon').first().css('display', 'none');
    }
    else if (name == 'Resume') {
      $(songControlsID()).find('.PauseIcon').first().css('display', 'none');
      $(songControlsID()).find('.PlayIcon').first().css('display', 'inline-block');
    }
  }
  return n;
}

function playThis(e, songID) {
  songUIID = songID;
  console.log('Play this');
  url = $(e).data('url');
  name = $(e).data('name');
  playStuff(name, url);
}

function playStuff(name, url) {
  console.log('Play stuff');
  // Ready to use; soundManager.createSound() etc. can now be called.
  //alert('ready!');
  soundManager.destroySound('sound');
  //createPlayerProgress();
  var mySound = soundManager.createSound({
    id: 'sound',
    url: url,
    whileplaying: updateBarPlaying,
    whileloading: updateBarLoading,
    onplay: changePlayButton('Pause'),
    onpause: changePlayButton('Resume'),
    onresume: changePlayButton('Pause')
  });
  mySound.play();
  currentSound = mySound;
  playingID = currentID;
  // var name = $('#detailsHeaderTitle').html();
  $('#nowPlaying').html(name);
  $('#playbar').css('display', 'inline-block');
}

function togglePause() {
  soundManager.togglePause('sound');
  $(songControlsID()).find('.PlayIcon').first().attr('onclick', "togglePause()");
}

function setupSongDisplay(id) {
  console.log('Setup song display');
  currentID = id;
  createPlayerProgress();
  if(currentID == playingID) {
    $(songControlsID()).find('.PlayIcon').first().attr('onclick', "togglePause()");
    if(!currentSound.paused) {
      $(songControlsID()).find('.PauseIcon').first().css('display', 'inline-block');
      $(songControlsID()).find('.PlayIcon').first().css('display', 'none');
    }
    updateBarPlaying();
  }
}
