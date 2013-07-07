$(function() {
	$('#albumTrackListing').addClass('Visible');
});

$('#artistname').val(getArtistNameFromURL());
$('#albumArt').click(function() {
	$('#image_file').click();
});
$('#image_file').change(function() {
	$('#new_image').submit();
	$('#changeAlbumImageSpinner').addClass('Spinner');
	$('#changeAlbumImageSpinner').css('display', 'inline-block');
	$('#albumArtDarken').css('opacity', 1);
});
$('#album_target').load(function() {
	var JSON = JSONFromID('album_target');
	$('#changeAlbumImageSpinner').removeClass('Spinner');
	$('#changeAlbumImageSpinner').css('display', 'none');
	$('#albumArtDarken').css('opacity', 0);
	$('#album_art_id').val(JSON['img_id']);
	$('#album_art').attr('src', JSON['img_src']);
});
$('#new_album').bind('ajax:success', function(evt, data, status, xhr) {
	// var JSON = eval(xhr);
	var JSON = jQuery.parseJSON(xhr.responseText);
	$('#newAlbumID').text(JSON['album_id']);
	console.log('Successfully created new album');
	console.log('JSON: ' + JSON);
	console.log('JSON[album_id]: ' + JSON['album_id']);
	$('#newAlbumFeedback').addClass('alert-success');
	$('#newAlbumFeedback').slideDown();
	$('#newAlbumSongs').addClass('SongGridActive');
});

$('.SongGridItem').click(function() {
	if ($(this).hasClass('SelectedSong'))
		$(this).removeClass('SelectedSong');
	else
		$(this).addClass('SelectedSong');
});