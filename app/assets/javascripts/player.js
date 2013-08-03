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
    playerProgress = new CircularProgress({
        radius: 48,
        strokeStyle: 'white',
        lineCap: 'round',
        lineWidth: 8
    });
    document.getElementById('songControls').appendChild(playerProgress.el);
    playerProgress.update(0);
}

var currentSound = false;

var playingID = false;
var currentID = false;

function updateBarPlaying() {
    if(currentSound) {
        var pgp = (100.0 * currentSound.position) / currentSound.durationEstimate;
        $('.position').css('width', pgp + '%');
        if (playingID == currentID) {
            playerProgress.update(pgp);
        }
    }
}

function updateBarLoading() {
    if(currentSound) {
        var pgp = (100.0 * currentSound.bytesLoaded) / currentSound.bytesTotal
        $('.loading').css('width', pgp + '%');
    }
}

function changePlayButton(name) {
    function n() {
        $('#playPauseBtn').text(name);
        if (name == 'Pause') {
            $('#pauseIcon').css('display', 'inline-block');
            $('#playIcon').css('display', 'none');
        }
        else if (name == 'Resume' || name == 'Play') {
            $('#pauseIcon').css('display', 'none');
            $('#playIcon').css('display', 'inline-block');
        }
    }
    return n;
}

function playThis(e) {
    url = $(e).data('url');
    name = $(e).data('name');
    playStuff(name, url);
}

function playStuff(name, url) {
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
        onresume: changePlayButton('Pause'),
        onfinish: changePlayButton('Play')
    });
    mySound.play();
    currentSound = mySound;
    playingID = currentID;
    $('.position').css('width', '0%');
    $('.loading').css('width', '0%');
    // var name = $('#detailsHeaderTitle').html();
    $('#nowPlaying').html(name);
    $('#playbar').css('display', 'inline-block');
}

function togglePause() {
    soundManager.togglePause('sound');
    $('#playIcon').attr('onclick', "togglePause()");
}

function setupSongDisplay(id) {
    currentID = id;
    createPlayerProgress();
    if(currentID == playingID) {
        $('#playIcon').attr('onclick', "togglePause()");
        if(!currentSound.paused) {
            $('#pauseIcon').css('display', 'inline-block');
            $('#playIcon').css('display', 'none');
        }
        updateBarPlaying();
    }
}
