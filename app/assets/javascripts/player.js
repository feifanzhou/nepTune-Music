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

function updateBar() {
    if(currentSound) {
       // $('#playbar.statusbar.position').style.width =
        // currentSound.position/currentSound.duration;
        $('.position').css('width', 100*currentSound.position/currentSound.duration + '%');
    }
}

function playStuff(url) {
    // Ready to use; soundManager.createSound() etc. can now be called.
    //alert('ready!');
    soundManager.destroySound('sound');
    var mySound = soundManager.createSound({
        id: 'sound',
        url: url, //'/system/audio/files/000/000/011/original/dr_who_next_stop_everywhere.mp3'
        whileplaying: updateBar
    });
    mySound.play();
    currentSound = mySound;
    var name = $('#detailsHeaderTitle').html()
    $('#nowPlaying').html(name);
}

function togglePause() {
    soundManager.togglePause('sound');

}
