$(function() {
	$('#albumTrackListing').addClass('Visible');
});

$('#albumArt').click(function() {
	$('#image_file').click();
});
$('#image_file').change(function() {
	$('#new_image').submit();
});
$('#album_target').load(function() {
	var JSON = JSONFromID('album_target');
	alert(JSON);
});