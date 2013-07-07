$(function() {
	$('#albumTrackListing').addClass('Visible');
});

$('#artistname').val(getArtistNameFromURL());
$('#albumArt').click(function() {
	$('#image_file').click();
});
$('#image_file').change(function() {
	$('#new_image').submit();
});
$('#album_target').load(function() {
	var JSON = JSONFromID('album_target');
	console.log('album_target loaded');
	console.log('JSON: ' + JSON);
	$('#album_art_id').val(JSON['img_id']);
	$('#album_art').attr('src', JSON['img_src']);
});
$('#new_album').bind('ajax:success', function() {
	console.log('Successfully created new album');
	$('#newAlbumFeedback').addClass('alert-success');
	$('#newAlbumFeedback').slideDown();
});