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

$(function() {
  var left = $('#artistSidebar').position().left;
  $('#sidebarShadowTop').css('left', (left + 'px'));
  $('#sidebarShadowBottom').css('left', (left + 'px'));
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

var contentScrollTop = 0;

function primeClick() {
  $('.MediaDisplayLink').click(function(event) {
    event.preventDefault();

    $('#musicGridContainer').addClass('MusicGridDetails');
    $('#musicGridFilter').addClass('Hidden');
    $('#musicDetailsHeader').addClass('Visible');

    $('#itemIcon').html($(this).attr('data-icon'));
    $('#detailsHeaderTitle').html($(this).attr('data-name'));

    contentScrollTop = $('#artistPageContent').scrollTop();

    var path = $(this).attr('href');
    setTimeout(function() {
      $('#musicDetailsHeader').css('z-index', 2);
      /* if (contentScrollTop > 160)
				$('#artistPageContent').animate({
					scrollTop: 160
				}, 1000); */
      $('#musicDetailsContent').load(path, function() {
				setTimeout(function() {
					$('#albumTrackListing').addClass('Visible');
				}, 300);
			});
    }, 750);
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
    $('#artistPageContent').animate({
			scrollTop: contentScrollTop
    });
  }, 750);
}

$(function() {
  $('#detailsHeaderBack').click(returnToMusicGrid());
});

function capitalizeFirstLetter(string) {
  return string.charAt(0).toLowerCase() + string.slice(1);
}

function setCalendarDisplayMode(cls) {
  $('#eventsCalendar').removeClass();
  $('#eventsCalendar').addClass(cls);
  var viewModeID = '#' + capitalizeFirstLetter(cls);
  $('.InlineViewMode').each(function() {
    $(this).removeClass('ViewModeSelected');
  });
  console.log(viewModeID);
  $(viewModeID).addClass('ViewModeSelected');
}

$(function() {
	$('.ArtistNavIcon').tooltip();
});

$(function() {
	$('#sliderContainer').mouseenter(function() {
		$('.SliderTitle').fadeIn();
		$('.SliderTitle').css('bottom', '0px');
	});
	$('#sliderContainer').mouseleave(function() {
		$('.SliderTitle').fadeOut();
		$('.SliderTitle').css('bottom', '-50px');
	});
});
$(function() {
	$('.NoblockTitle').mouseenter(function() {
		$(this).fadeOut();
	});
});

function setSliderOffset(sliderOffset) {
	$('#slider').css('left', (sliderOffset + 'px'));
}

$(function() {
  var firstElementWidth = $('#gallery0').width();
  var sliderContainerWidth = $('#sliderContainer').width();
  var sliderStartingOffset = (sliderContainerWidth - firstElementWidth) / 2;
  setSliderOffset(sliderStartingOffset);
});

function setGalleryNavStatus(currObj) {
	console.log('setGalleryNavStatus: ' + currObj);
	if ($(currObj)[0] === $('.SliderElement').first()[0])
		$('#sliderNavLeft').addClass('SliderNavDisabled');
	else
		$('#sliderNavLeft').removeClass('SliderNavDisabled');

	if ($(currObj)[0] === $('.SliderElement').last()[0])
		$('#sliderNavRight').addClass('SliderNavDisabled');
	else
		$('#sliderNavRight').removeClass('SliderNavDisabled');
}

function galleryToElement(index) {
	var prevWidths = 0;
	var elm;
	$('.SliderElementCurrent').removeClass('SliderElementCurrent');
	for (var i = 0; i <= index; i++) {
		elm = $('#gallery' + i);
		if (i < index)
			prevWidths += $(elm).width();
	}
	var centerOffset = ($('#sliderContainer').width() - $(elm).width()) / 2;
	var totalOffset = -1 * prevWidths + centerOffset;
	setSliderOffset(totalOffset);
	$(elm).addClass('SliderElementCurrent');
	setGalleryNavStatus(elm);
}

function galleryToHash() {
	var hash = window.location.hash.slice(1);
	if (isNaN(hash) || hash.length === 0) {
		return;
	}
	galleryToElement(hash);
}

$(function() {
	galleryToHash();
});

$(window).bind('hashchange', function () {
	galleryToHash();
});

$('.SliderNav').click(function() {
	if ($(this).hasClass('SliderNavDisabled'))
		return false;

	var objId = $(this).attr('id');
	var hash = window.location.hash.slice(1);
	if (hash.length === 0 || isNaN(hash)) {	// No hash, default to 0
		window.location.hash = '#1';
		return false;
	}
	hash = parseInt(hash, 10);
	if (objId == 'sliderNavLeft')
		hash -= 1;
	else
		hash += 1;
	console.log('new hash: ' + hash);
	location.hash = ('#' + hash);
	return false;
});