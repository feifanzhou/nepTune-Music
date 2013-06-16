/* $(function() {
  $("#musicGrid").masonry({
    itemSelector: '.GridItem',
    columnWidth: floor($('#musicGrid').width() * 0.20)
  })
}) */

$(function() {
	var elm = $("#artistSidebar");

	$(elm).scroll(function() {
		if (elm.scrollTop() > 15)
      $("#sidebarShadowTop").fadeTo(1.0, 1.0);
    else
      $("#sidebarShadowTop").fadeTo(1.0, 0.0);

    if (elm.innerHeight() + elm.scrollTop() > (elm.scrollHeight - 5))
      $("#sidebarShadowBottom").fadeTo(1.0, 0.0);
    else
      $("#sidebarShadowBottom").fadeTo(1.0, 1.0);
	});
});

function filterMusic(tag) {
  $(".FilterItem").each(function() {
    $(this).removeClass('SelectedFilter');
  });
  $(".MusicGridGroupHeader").each(function() {
    $(this).css('display', 'none');
  });
  $("#noFilterMatches").css('display', 'none');
  switch (tag) {
    case 0:
      $(".MusicGridGroupHeader").each(function() {
        $(this).css('display', 'block');
      });
      $("#filterAll").addClass('SelectedFilter');
      $("#musicGridAlbums").css('display', 'block');
      $("#musicGridSongs").css('display', 'block');
      $("#noFilterMatches").css('display', 'none');
      break;
    case 1:
      $("#filterSongs").addClass('SelectedFilter');
      $("#musicGridAlbums").css('display', 'none');
      $("#musicGridSongs").css('display', 'block');
      break;
    case 2:
      $("#filterAlbums").addClass('SelectedFilter');
      $("#musicGridAlbums").css('display', 'block');
      $("#musicGridSongs").css('display', 'none');
      $("#noFilterMatches").css('display', 'none');
      break;
    case 3:
    case 4:
    default:
      $("#musicGridAlbums").css('display', 'none');
      $("#musicGridSongs").css('display', 'none');
      $("#noFilterMatches").css('display', 'block');
      break;
  }
}
$(function() {
	$(".MediaDisplayLink").click(function(event){
		event.preventDefault();

		/* $('#musicGrid').animate({
			marginLeft: '-980px',
			marginRight: '980px'
		}, 500, function() {
			console.log('animation done');
		}); */
		$('#musicGridContainer').addClass('MusicGridDetails');
    $('#musicGridFilter').addClass('Hidden');

		// TODO: Load AJAX song or album content
		var path = $(this).attr('href');
		console.log(path);
		var odv = document.createElement("div");
		$(odv).load(path);
		document.appendChild(odv);

		return false; //for good measure
	});
});

function returnToMusicGrid() {
  $('#musicGridContainer').removeClass('MusicGridDetails');
  $('#musicGridFilter').removeClass('Hidden');
}