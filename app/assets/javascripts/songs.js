$('body').on('click', '#clearGeneralFields', function() {
  // $('#clearGeneralFields').click(function(event) {
  event.preventDefault();
  $('#all_songs_song_name').val('');
  $('#all_songs_song_album').val('');
  $('#all_songs_song_track_number').val('');
  return false;
});

// Fill in artist name from URL
$('#artistname').val(getArtistNameFromURL());
$(window).on('djaxLoad', function() {
  $('#artistname').val(getArtistNameFromURL());
});

$('body').on('click', '#select_file_button', function() {
  // $('#select_file_button').click(function() {
  $('#audio_file').click();
});
$('body').on('change', '#audio_file', function() {
  // $('#audio_file').change(function() {
  // http://stackoverflow.com/a/10683277/472768
  var fileName = $(this).val().split('/').pop().split('\\').pop();
  $('#selectedFileName').text("'" + fileName + "' selected");
  $('#new_audio').submit();

  console.log('Matching name regex');
  var re = /^\d+ [^0-9-\s][^.]+/;
  var songName;
  var trackNumber;
  if (re.test(fileName)) {
    console.log('Match 1');
    songName = (fileName.match(/[^0-9-\s][^.]+/))[0];
    trackNumber = (fileName.match(/^\d+/))[0];
  }
  re = /^\d+\s?-\s?[^0-9-\s][^.]+/;
  if (re.test(fileName)) {
    console.log('Match 2');
    songName = (fileName.match(/[^0-9-\s][^.]+/))[0];
    trackNumber = (fileName.match(/^\d+/))[0];
  }
  re = /^\d+\.\s?[^0-9-\s][^.]+/;
  if (re.test(fileName)) {
    console.log('Match 3');
    songName = (fileName.match(/[^0-9-\s][^.]+/))[0];
    trackNumber = (fileName.match(/^\d+/))[0];
  }
  re = /Track \d+/;
  if (re.test(fileName))
    trackNumber = (fileName.match(/\d+/))[0];
  re = /Track\s?-\s?\d+/;
  if (re.test(fileName))
    trackNumber = (fileName.match(/\d+/))[0];
  re = /Song \d+/;
  if (re.test(fileName))
    trackNumber = (fileName.match(/\d+/))[0];
  re = /Song\s?-\s?\d+/;
  if (re.test(fileName))
    trackNumber = (fileName.match(/\d+/))[0];
  re = /[^0-9-\s][^.]+/;
  if (re.test(fileName))
    songName = (fileName.match(re))[0];
  console.log('songName: ' + songName + ', trackNumber: ' + trackNumber);
  trackNumber = trackNumber.replace(/^0+/, '');
  $('#song_name').val($.trim(songName));
  $('#song_track_number').val($.trim(trackNumber));
});

// $('#newSongDetails').on('load', '#audio_target', function() {

// $('#audio_target').load(function() {
function audio_target_loaded() {
  console.log('audio target load');
  var iframeText = document.getElementById('audio_target').contentWindow.document.body.textContent;
  console.log('iframeText: ' + iframeText);
  var scriptStart = iframeText.indexOf('window');
  if (scriptStart !== -1) {
    console.log('Script found');
    iframeText = iframeText.substring(0, scriptStart);
  }
  var json = JSON.parse(iframeText);
  $('#song_audio_id').val(json['audio_id']);
}
$('#audio_target').load(function() {
  audio_target_loaded();
});
$(window).bind('djaxLoad', function() {
  $('#audio_target').load(function() {
    audio_target_loaded();
  });
});

var suggestionImagePaths;
$('body').on('keyup', '#song_album', function() {
  // $('#song_album').keyup(function(event) {
  console.log('song album keyup');
  if (event.keyCode == 8 && $(this).val().length < 1) {	// backspace
    $('#albumSuggestions').empty();
    return;
  }
  if (event.keyCode == 40 || event.keyCode == 38)	// arrow keys
    return;
  var albumNameInput = $(this).val();
  $.ajax({
    url: '/json/album_name_suggestions',
    method: 'POST',
    data: {
      input: albumNameInput
    },
    success: function(resp) {
      var resp_json = eval(resp['names']);
      suggestionImagePaths = eval(resp['paths']);
      $('#albumSuggestions').empty();
      for (var i = 0; i < resp_json.length; i++) {
        var li = "<li class='AlbumSuggestion' id='suggestion" + i + "'>" + resp_json[i] + '</li>';
        $('#albumSuggestions').append(li);
      }
      // Position suggestions list
      var textFieldTop = $('#song_album').position().top;
      var textFieldHeight = $('#song_album').height();
      $('#albumSuggestions').css('top', (textFieldHeight + textFieldTop + 8) + 'px');
    }
  });
});
function beginAlbumArtUpdate() {
  $('#albumImageDarken').css('opacity', 1);
  $('#changeAlbumImageSpinner').css('display', 'inline-block');
  $('#changeAlbumImageSpinner').addClass('Spinner');
}
function endAlbumArtUpdate() {
  $('#albumImageDarken').css('opacity', 0);
  $('#changeAlbumImageSpinner').css('display', 'none');
  $('#changeAlbumImageSpinner').removeClass('Spinner');
}
// TODO: Remove duplicate code here
$('body').on('keydown', '#song_album', function() {
  // $('#song_album').keydown(function(event) {
  if (event.keyCode == 13)	// return key
    event.preventDefault();
  if (event.keyCode !== 40 && event.keyCode !== 38)
    return;
  var currentSelection = $('.SelectedSuggestion');
  $('.SelectedSuggestion').each(function() {
    $(this).removeClass('SelectedSuggestion');
  });
  if (event.keyCode == 40) {	// Key down
    var currentIndex = -1;
    if (currentSelection.length) {	// Something selected
      var slicedID = $(currentSelection).attr('id').slice(10);
      currentIndex = parseInt(slicedID, 10);
    }
    if (currentIndex !== ($('.AlbumSuggestion').length - 1))	// Selected last one
      currentIndex++;
    var newID = '#suggestion' + currentIndex;
    $(newID).addClass('SelectedSuggestion');
    var suggestion = $(newID).text();
    $('#song_album').val(suggestion);
    var imgPath = suggestionImagePaths[currentIndex];
    beginAlbumArtUpdate();
    $('.NewSongArt').attr('src', imgPath);
    event.preventDefault();
  }
  else if (event.keyCode == 38) {	// Key up
    var currentIndex = -1;
    if (currentSelection.length) {	// Something selected
      var slicedID = $(currentSelection).attr('id').slice(10);
      currentIndex = parseInt(slicedID, 10);
    }
    if (currentIndex > 0)
      currentIndex--;
    var newID = '#suggestion' + currentIndex;
    $(newID).addClass('SelectedSuggestion');
    var suggestion = $(newID).text();
    $('#song_album').val(suggestion);
    var imgPath = suggestionImagePaths[currentIndex];
    beginAlbumArtUpdate();
    $('.NewSongArt').attr('src', imgPath);
    event.preventDefault();
  }
});
$('body').on('blur', '#song_album', function() {
  // $('#song_album').blur(function() {
  $('#albumSuggestions').empty();
});
$('body').on('load', '.NewSongArt', function() {
  // $('.NewSongArt').load(function() {
  endAlbumArtUpdate();
});
// $('.NewSongArt').load(function() {
//  endAlbumArtUpdate;
// });
$(window).bind('djaxLoad', function() {
  $('.NewSongArt').load(function() {
    endAlbumArtUpdate;
  });
});

$('body').on('click', '#newSongPreview', function() {
  // $('#newSongPreview').click(function() {
  $('#image_file').click();
});
$('body').on('change', '#image_file', function() {
  // $('#image_file').change(function() {
  $('#new_image').submit();
});
$('body').on('submit', '#new_image', function() {
  // $('#new_image').submit(function() {
  beginAlbumArtUpdate();
});
function album_target_loaded() {
  endAlbumArtUpdate();
  var json = JSON.parse(document.getElementById('album_target').contentWindow.document.body.textContent);
  $('.NewSongArt').attr('src', json['img_src']);
  $('#song_album_art_id').val(json['img_id']);
}
$('#album_target').load(function() {
  album_target_loaded();
});
$(window).bind('djaxLoad', function() {
  $('#album_target').load(function() {
    album_target_loaded();
  });
});
function hideNewSongFeedback() {
  $('#newSongFeedback').removeClass('alert-success');
  $('#newSongFeedback').css('display', 'none');
}
function new_song_success() {
  console.log('Song created successfully');
  $('#newSongFeedback').addClass('alert-success');
  $('#newSongFeedback').slideDown();
}
$('#new_song').bind('ajax:success', function() {
  new_song_success()
});
$(window).bind('djaxLoad', function() {
  $('#new_song').bind('ajax:success', function() {
    new_song_success()
  });
});
$('body').on('focus', '#new_song > *', function() {
  // $('#new_song > *').focus(function() {
  hideNewSongFeedback();
});

$('body').on('mouseout', '.RelatedMedia', function() {
  $('.RelatedMediaCaption').removeClass('In');
});

$('body').on('mouseover', '.CommentSong', function() {
  $('.RelatedMediaCaption').addClass('In');
  var name = $(this).data('name');
  var creator = $(this).data('creator');
  $('.RelatedMediaName').text(name);
  $('.RelatedMediaCreator').text(creator);
});