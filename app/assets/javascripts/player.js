soundsoundManager.reset();
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
        alert('broken');
    }
});


var currentSound = false;

function updateBarPlaying() {
    if(currentSound) {
        $('.position').css('width', 100*currentSound.position/currentSound.durationEstimate + '%');
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
    }
    return n;
}

function playStuff(url) {
    // Ready to use; soundManager.createSound() etc. can now be called.
    //alert('ready!');
    soundManager.destroySound('sound');
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
    var name = $('#detailsHeaderTitle').html();
    $('#nowPlaying').html(name);
    $('#playbar').css('display', 'inline-block');
}

function togglePause() {
    soundManager.togglePause('sound');

}