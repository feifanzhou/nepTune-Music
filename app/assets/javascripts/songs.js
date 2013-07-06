$('#clearGeneralFields').click(function(event) {
	event.preventDefault();
	$('#all_songs_song_name').val('');
	$('#all_songs_song_album').val('');
	$('#all_songs_song_track_number').val('');
	return false;
});

// Fill in artist name from URL
$('#artistname').val(getArtistNameFromURL());

var suggestionImagePaths;
$('#song_album').keyup(function(event) {
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
$('#song_album').keydown(function(event) {
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
$('#song_album').blur(function() {
	$('#albumSuggestions').empty();
});
$('.NewSongArt').load(function() {
	endAlbumArtUpdate();
});

$('#newSongPreview').click(function() {
	$('#image_file').click();
});
$('#image_file').change(function() {
	$('#new_image').submit();
});
$('#new_image').submit(function() {
	beginAlbumArtUpdate();
});
$('#album_target').load(function() {
	endAlbumArtUpdate();
	var json = JSON.parse(document.getElementById('album_target').contentWindow.document.body.textContent);
	$('.NewSongArt').attr('src', json['img_src']);
	$('#song_album_art_id').attr('val', json['img_id']);
});
$('#new_song').bind('ajax:success', function() {
	console.log('Song created successfully');
	$('#newSongFeedback').addClass('alert-success');
	$('#newSongFeedback').css('display', 'block');
});