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
      $("#filterVideos").addClass('SelectedFilter');
      $("#musicGridAlbums").css('display', 'none');
      $("#musicGridSongs").css('display', 'none');
      $("#noFilterMatches").css('display', 'block');
      break;
    case 4:
      $("#filterOthers").addClass('SelectedFilter');
      $("#musicGridAlbums").css('display', 'none');
      $("#musicGridSongs").css('display', 'none');
      $("#noFilterMatches").css('display', 'block');
      break;
    default:
      $("#musicGridAlbums").css('display', 'none');
      $("#musicGridSongs").css('display', 'none');
      $("#noFilterMatches").css('display', 'block');
      break;
  }
}

function primeClick() {
  $('.MediaDisplayLink').click(function(event) {
    event.preventDefault();

    $('#musicGridContainer').addClass('MusicGridDetails');
    $('#musicGridFilter').addClass('Hidden');
    $('#musicDetailsHeader').addClass('Visible');

    $('#itemIcon').html($(this).attr('data-icon'));
    $('#detailsHeaderTitle').html($(this).attr('data-name'));

    var path = $(this).attr('href');
    setTimeout(function() {
      $('#musicDetailsHeader').css('z-index', 2);
      $('#musicDetailsContent').load(path);
      // $('#musicDetailsContent').html('<p>Hello</p>');
    }, 1000);

    return false; //for good measure
  });
}

$(function() {
  primeClick();
});

function returnToMusicGrid() {
  $('#musicGridContainer').removeClass('MusicGridDetails');
  $('#musicGridFilter').removeClass('Hidden');
  $('#musicDetailsHeader').css('z-index', -1);
  $('#musicDetailsHeader').removeClass('Visible');
  primeClick();
  setTimeout(function() {
    $('#itemIcon').empty();
    $('#detailsHeaderTitle').empty();
    $('#musicDetailsContent').empty();
  }, 1000);
}

$(function() {
  $('#detailsHeaderBack').click(returnToMusicGrid());
});