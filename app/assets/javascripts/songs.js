$('#clearGeneralFields').click(function(event) {
	event.preventDefault();
	$('#all_songs_song_name').val('');
	$('#all_songs_song_album').val('');
	$('#all_songs_song_track_number').val('');
	return false;
});