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
$('#new_album').bind('ajax:success', function() {
	console.log('Successfully created new album');
	$('#newAlbumFeedback').addClass('alert-success');
	$('#newAlbumFeedback').slideDown();
});

$('.SongGridItem').click(function() {
	if ($(this).hasClass('SelectedSong'))
		$(this).removeClass('SelectedSong');
	else
		$(this).addClass('SelectedSong');
});