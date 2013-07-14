// $(function() {
$(window).bind('djaxLoad', function() {
	$('#albumTrackListing').addClass('Visible');
});

$('#artistname').val(getArtistNameFromURL());
$(window).bind('djaxLoad', function() {
	$('#artistname').val(getArtistNameFromURL());
});
$('body').on('click', '#albumArt', function() {
// $('#albumArt').click(function() {
	$('#image_file').click();
});
$('body').on('change', '#image_file', function() {
// $('#image_file').change(function() {
	$('#new_image').submit();
	$('#changeAlbumImageSpinner').addClass('Spinner');
	$('#changeAlbumImageSpinner').css('display', 'inline-block');
	$('#albumArtDarken').css('opacity', 1);
});
function image_target_loaded() {
	console.log('image target loaded');
	var iframeText = document.getElementById('album_target').contentWindow.document.body.textContent;
	console.log('iframeText: ' + iframeText);
	var scriptStart = iframeText.indexOf('window');
	if (scriptStart !== -1) {
		console.log('Script found');
		iframeText = iframeText.substring(0, scriptStart);
	}
	console.log('new iframeText: ' + iframeText);
	var json = JSON.parse(iframeText);
	console.log('JSON: ' + json);
	$('#changeAlbumImageSpinner').removeClass('Spinner');
	$('#changeAlbumImageSpinner').css('display', 'none');
	$('#albumArtDarken').css('opacity', 0);
	$('#album_art_id').val(json['img_id']);
	$('#album_art').attr('src', json['img_src']);
}
$('#album_target').bind('load', function() {
	image_target_loaded();
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

$('body').on('click', '.SongSelected', function() {
// $('.SongSelected').click(function(event) {
	// if (!$(this).hasClass('SelectedSong'))
	event.preventDefault();
	return false;
});

$('body').on('click', '.SongGridItem', function() {
// $('.SongGridItem').click(function() {
	var shouldAddToAlbum;
	var clicked = $(this);
	if ($(this).hasClass('SelectedSong')) {
		$(this).removeClass('SelectedSong');
		shouldAddToAlbum = 0;
	}
	else {
		$(this).addClass('SelectedSong');
		shouldAddToAlbum = 1;
	}
	console.log('shouldAddToAlbum: ' + shouldAddToAlbum);
	var songID = $(clicked).attr('id').slice(4);
	console.log('songID: ' + songID);
	var albumID = $('#newAlbumID').text();
	console.log('albumID: ' + albumID);
	$.ajax({
		url: '/songs/' + songID,
		method: 'PUT',
		data: {
			albumID: albumID,
			shouldAdd: shouldAddToAlbum
		},
		success: function(resp) {
			if (shouldAddToAlbum === 1)
				console.log('Successfully added song to album');
			else
				console.log('Successfully removed song from album');
		}
	});
});
$('body').on('keydown', '.TrackNumberField', function() {
// $('.TrackNumberField').keydown(function(event) {
  if (event.keyCode !== 13)
    return;
  event.preventDefault();
  $(this).blur();
  return false;
});
$('body').on('blur', '.TrackNumberField', function() {
// $('.TrackNumberField').blur(function(event) {
	var input = $(this);
	var tn = $(this).val();
	var s_id = ($(this).attr('id').split("_"))[1];
	console.log("s_id: " + s_id);
	$.ajax({
		url: '/songs/' + s_id,
		method: 'PUT',
		data: {
			track_number: tn
		},
		success: function(resp) {
			console.log('Successfully changed track number');
		}
	});
});