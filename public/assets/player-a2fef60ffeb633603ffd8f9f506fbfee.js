function createPlayerProgress(){console.log("Create player progress"),playerProgress=new CircularProgress({radius:48,strokeStyle:"white",lineCap:"round",lineWidth:8}),$(".SongControls").first().append(playerProgress.el),playerProgress.update(0)}function songControlsID(){return'*[data-songid="'+songUIID+'"]'}function resetOnClickForCurrent(){var n="playThis(this, "+songUIID+")";$(songControlsID()).find(".PlayIcon").attr("onclick",n)}function updateBarPlaying(){if(currentSound){var n=100*currentSound.position/currentSound.durationEstimate;$(".position").css("width",n+"%"),playingID==currentID&&playerProgress.update(n)}}function updateBarLoading(){currentSound&&$(".loading").css("width",100*currentSound.duration/currentSound.durationEstimate+"%")}function changePlayButton(n){function o(){"Pause"==n?($(songControlsID()).find(".PauseIcon").css("display","inline-block"),$(songControlsID()).find(".PlayIcon").css("display","none"),$("#playPauseBtn .PlayIcon").css("display","none"),$("#playPauseBtn .PauseIcon").css("display","inline-block")):"Resume"==n&&($(songControlsID()).find(".PauseIcon").css("display","none"),$(songControlsID()).find(".PlayIcon").css("display","inline-block"),$("#playPauseBtn .PlayIcon").css("display","inline-block"),$("#playPauseBtn .PauseIcon").css("display","none"))}return o}function playThis(n,o){currentSound&&(console.log("There is a currentSound"),currentSound.paused||(console.log("Current sound is not paused"),$(songControlsID()).find(".PlayIcon").css("display","inline-block"),$(songControlsID()).find(".PauseIcon").css("display","none")),resetOnClickForCurrent()),songUIID=o,console.log("Play this"),url=$(n).data("url"),name=$(n).data("name"),playStuff(name,url)}function playStuff(n,o){console.log("Play stuff"),soundManager.destroySound("sound");var s=soundManager.createSound({id:"sound",url:o,whileplaying:updateBarPlaying,whileloading:updateBarLoading,onplay:changePlayButton("Pause"),onpause:changePlayButton("Resume"),onresume:changePlayButton("Pause")});s.play(),currentSound=s,playingID=currentID,$("#nowPlaying").html(n),$("#playbar").css("display","inline-block")}function togglePause(){soundManager.togglePause("sound"),$(songControlsID()).find(".PlayIcon").attr("onclick","togglePause()")}function setupSongDisplay(n){console.log("Setup song display"),currentID=n,songUIID&&createPlayerProgress(),currentID==playingID&&($(songControlsID()).find(".PlayIcon").attr("onclick","togglePause()"),currentSound.paused||($(songControlsID()).find(".PauseIcon").css("display","inline-block"),$(songControlsID()).find(".PlayIcon").css("display","none")),updateBarPlaying())}soundManager.reset(),soundManager.setup({url:"/swf/",flashVersion:9,preferFlash:!1,onready:function(){},ontimeout:function(){}}),console.log("player setup!"),console.log(soundManager);var playerProgress,currentSound=!1,playingID=!1,currentID=!1,songUIID=!1;