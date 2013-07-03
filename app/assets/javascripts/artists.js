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

$('#sliderContainer').mouseenter(function() {
	$('.SliderTitle').fadeIn();
	$('.SliderTitle').css('bottom', '0px');
});
$('#sliderContainer').mouseleave(function() {
	$('.SliderTitle').fadeOut();
	$('.SliderTitle').css('bottom', '-50px');
});
$('.NoblockTitle').mouseenter(function() {
  $(this).fadeOut();
});
$('.SliderTitle').mouseenter(function() {
  $(this).css('background', 'rgba(0, 0, 0, 0.90)');
});
$('.SliderTitle').mouseleave(function() {
  $(this).css('background', 'rgba(0, 0, 0, 0.70)');
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

/***** Editing functionality *****/
function getArtistNameFromURL() {
  return document.URL.split("/")[3];
}

$('.AddElementFace').click(function() {
  var clicked = $(this);
  $('.AddElementOption').each(function() {
    var face = $(this).children('.AddElementFace');
    var info = $(this).children('.AddElementInfo');
    if ($(face)[0] === $(clicked)[0]) {
      $(face).css('display', 'none');
      $(info).css('display', 'block');
    }
    else {
      $(face).css('display', 'block');
      $(info).css('display', 'none');
    }
  });
});
$('.AddElementCancel').click(function() {
  var info = $(this).closest('.AddElementInfo');
  var face = $(info).siblings('.AddElementFace');
  $(face).css('display', 'block');
  $(info).css('display', 'none');
});
$('.AddVideoURL').keydown(function(event) {
  if (event.keyCode !== 13)
    return;
  event.preventDefault();
  $(this).blur();
  return false;
});
$('.AddVideoURL').blur(function(event) {
  var input = $(this);
  var URL = $(this).val();
  console.log('URL input text: ' + URL);
  if (URL.indexOf('youtube.com') >= 0) {
    var iframe = youtubeIframeForURL(URL);
    console.log('iframe: ' + iframe);
    $(input).css('display', 'none');
    $('#videoUploadPreview').append(iframe);
  }
});
function createGalleryItemWithContent(ctc, caption, index, m_id) {
  var se = "<div class='SliderElement' id='gallery" + index + "'>";
  se += "<div class='SliderElementRemoveOverlay'>";
  se += "<span class='Icon SliderElementRemove' id='remove" + index + "'";
  se += " data-media-id='" + m_id + "'>&#59407;</span></div>";
  se += "<h2 class='SliderTitle'><p class='TitleTextEdit' contenteditable data-media-id='" + m_id + "'>";
  se += "" + caption + "</p><p class='ClickToEdit'>Click on caption to edit</p></h2>";
  se += "" + ctc + "</div>";
  $('#slider').append(se);
}
$('#saveVideo').click(function() {
  var URL = youtubeEmbedForURL($('.AddVideoURL').val());
  var caption = $('#addVideoCaption').val();
  var order = $('.SliderElement').length;  // -1 for add element itself
  $.ajax({
    url: '/' + getArtistNameFromURL() + '/update_content',
    type: 'POST',
    data: { location: 'AboutGalleryItem',
            video_URL: URL,
            caption: caption,
            order: order
          },
    success: function(resp) {
      console.log('Successfully added gallery media');
      // Create gallery item
      m_id = resp["obj_id"];
      createGalleryItemWithContent(youtubeIframeForURL($('.AddVideoURL').val(), 640, 360), caption, order, m_id);
      // Change hash
      window.location.hash = '#' + order;
    }
  });
});

function renumberGalleryElements() {
  var index = 0;
  $('.SliderElement').each(function() {
    $(this).attr('id', ('gallery' + index));
    index++;
  });
  index = 0;
  $('.SliderElementRemove').each(function() {
    $(this).attr('id', ('remove' + index));
    index++;
  });
}

$('.SliderElementRemove').click(function() {
  var index = parseInt($(this).attr('data-media-id'), 10);
  var artistname = getArtistNameFromURL();
  var rm_el = $(this);
  $.ajax({
    url: "/" + artistname + "/remove_media",
    type: "POST",
    data: { location: 'AboutGallery',
            media_index: index
          },
    success: function(resp) {
      if (!resp)
        return;
      var scs = parseInt(resp['success'], 10);
      if (scs !== 1)
        return;

      index = parseInt($(rm_el).attr('id').slice(6), 10);
      $('#gallery' + index).fadeOut();
      setTimeout(function() {
        $('#gallery' + index).remove();
        renumberGalleryElements();
        // window.location.hash = '#' + window.location.hash.slice(1);
        galleryToHash();
      }, 400);
    }
  });
});

function updateCaptionForGalleryItem(newText, m_id) {
  $.ajax({
    url: '/' + getArtistNameFromURL() + '/update_content',
    type: 'POST',
    data: { location: 'AboutGalleryCaption',
            mediaID: m_id,
            newText: newText
          },
    success: function(resp) {
      console.log('Successfully changed media caption');
    }
  });
}
$('.TitleTextEdit').keydown(function(event){
  if (event.keyCode !== 13)  // Check for Return key
    return;

  event.preventDefault();
  $(this).blur();
  return false;
});
$('.TitleTextEdit').blur(function(event) {
  var m_id = parseInt($(this).attr('data-media-id'), 10);
  var text = $(this).html();
  updateCaptionForGalleryItem(text, m_id);
});

function updateStoryForArtist(newText) {
  $.ajax({
    url: '/' + getArtistNameFromURL() + '/update_content',
    type: 'POST',
    data: { location: 'AboutStory',
            newText: newText
          },
    success: function(resp) {
      // TODO: Should update text with stored version
      // which may include stripped HTML tags
      console.log('Successfully updated artist story');
    }
  });
}
$('.ArtistStory').keydown(function(event) {
  if (event.keyCode !== 13)
    return;
  event.preventDefault();
  $(this).blur();
  return false;
});
$('.ArtistStory').blur(function(event) {
  var nTxt = $(this).html();
  console.log('nTxt: ' + nTxt);
  updateStoryForArtist(nTxt);
});

function updateContactInfoForArtist(field, value) {
  $.ajax({
    url: '/' + getArtistNameFromURL() + '/update_content',
    type: 'POST',
    data: { location: 'AboutContactInfo',
            field: field,
            value: value
          },
    success: function(resp) {
      console.log('Successfully updated artist contact info');
    }
  });
}
$('.ContactText').keydown(function(event) {
  if (event.keyCode !== 13)
    return;
  event.preventDefault();
  $(this).blur();
  return false;
});
$('.ContactText').blur(function(event) {
  var value = $(this).html();
  console.log('value: ' + value);
  var field = $(this).attr('id');
  updateContactInfoForArtist(field, value);
});