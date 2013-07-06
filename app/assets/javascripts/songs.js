$('#clearGeneralFields').click(function(event) {
	event.preventDefault();
	$('#all_songs_song_name').val('');
	$('#all_songs_song_album').val('');
	$('#all_songs_song_track_number').val('');
	return false;
});

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
			var resp_json = eval(resp['results']);
			$('#albumSuggestions').empty();
			for (var i = 0; i < resp_json.length; i++) {
				var li = "<li class='AlbumSuggestion' id='suggestion" + i + "'>" + resp_json[i] + '</li>';
				$('#albumSuggestions').append(li);
			}
		}
	});
});
$('#song_album').keydown(function(event) {
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
		event.preventDefault();
	}
});
$('#song_album').blur(function() {
	$('#albumSuggestions').empty();
});