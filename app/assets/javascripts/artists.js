var elm = $("#artistSidebar");
if (elm.length > 0) {
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

  var left = $('#artistSidebar').position().left;
  $('#sidebarShadowTop').css('left', (left + 'px'));
  $('#sidebarShadowBottom').css('left', (left + 'px'));
}

$('body').on('click', '#editButton', function() {
  createCookie('is_editing', '1');
  $('#editButton').attr('id', 'uneditButton');
});
$('body').on('click', '#uneditButton', function() {
  createCookie('is_editing', '0');
  $('#uneditButton').attr('id', 'editButton');
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
            $('#musicDetailsContent').load(path + ' #mainPartial', function() {
                setTimeout(function() {
                    $('#albumTrackListing').addClass('Visible');
                }, 300);
            });
        }, 750);
//        return false; //for good measure
    });
}

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

// TODO: Clean up duplicate code
var sm = 25;  // Speed multiplier—lower value is faster ticker scroll speed
var st = 210; // Width threshold for scrolling in pixels
$('body').on('mouseover', '.GridItem', function() {
  var n = $(this).find('.GridItemName').first();
  $(n).stop(true);  // Stop animation and clear queue
  var w = $(n).width();
  if (w < st) // Grid item width 220 – name margin-left 8 – 2 extra
  return;
  var diff = w - st;
  var t = diff * sm;
  $(n).animate({
  left: ('-' + diff + 'px')
  }, t);
});
$('body').on('mouseout', '.GridItem', function() {
  var n = $(this).find('.GridItemName').first();
  $(n).stop(true);
  var w = $(n).width();
  if (w < st) // Grid item width 220 – name margin-left 8 – 2 extra
  return;
  var diff = w - st;
  var t = diff * sm;
  $(n).animate({
  left: ('0px')
  }, t);
});

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

$('body').on('click', '#newEventButton', function() {
  $('#backdrop').addClass('In');
  $('#newEvent').addClass('In');
});
$('body').on('click', '#newEvent .ModalDismiss', function() {
  $('#backdrop').removeClass('In');
  $('#newEvent').removeClass('In');
});

$(function() {
  $('.ArtistNavIcon').tooltip();
});
$(window).bind('djaxLoad', function() {
  $('.ArtistNavIcon').tooltip();
});

$('body').on('mouseenter', '#sliderContainer', function() {
  // $('#sliderContainer').mouseenter(function() {
  $('.SliderTitle').fadeIn();
  $('.SliderTitle').css('bottom', '0px');
});
// $('#sliderContainer').mouseleave(function() {
$('body').on('mouseleave', '#sliderContainer', function() {
  $('.SliderTitle').fadeOut();
  $('.SliderTitle').css('bottom', '-50px');
});
$('body').on('mouseenter', '.NoblockTitle', function() {
  // $('.NoblockTitle').mouseenter(function() {
  $(this).fadeOut();
});
$('body').on('mouseenter', '.SliderTitle', function() {
  // $('.SliderTitle').mouseenter(function() {
  $(this).css('background', 'rgba(0, 0, 0, 0.90)');
});
$('body').on('mouseleave', '.SliderTitle', function() {
  // $('.SliderTitle').mouseleave(function() {
  $(this).css('background', 'rgba(0, 0, 0, 0.70)');
});

function setSliderOffset(sliderOffset) {
  $('#slider').css('left', (sliderOffset + 'px'));
}

function initialPositionAboutGallery() {
  var firstElementWidth = $('#gallery0').width();
  var sliderContainerWidth = $('#sliderContainer').width();
  var sliderStartingOffset = (sliderContainerWidth - firstElementWidth) / 2;
  setSliderOffset(sliderStartingOffset);
}
$(function() {
  initialPositionAboutGallery();
});

$(window).bind('djaxLoad', function() {
  initialPositionAboutGallery();
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
$(window).bind('djaxLoad', function() {
  galleryToHash();
});

$(window).bind('hashchange', function () {
  galleryToHash();
});

function sliderNavClick(n) {
  console.log('slidernav click');
  if ($(n).hasClass('SliderNavDisabled'))
  return false;

  var objId = $(n).attr('id');
  console.log('slider nav id: ' + objId);
  var hash = window.location.hash.slice(1);
  if (hash.length === 0 || isNaN(hash)) { // No hash, default to 0
  window.location.hash = '#1';
  return false;
  }
  hash = parseInt(hash, 10);
  if (objId == 'sliderNavLeft') {
  console.log('Slider nav left');
  hash -= 1;
  }
  else {
  console.log('Slider nav right');
  hash += 1;
  }
  console.log('new hash: ' + hash);
  location.hash = ('#' + hash);
  return false;
}
$('body').on('click.nav', '.SliderNav', function() {
  sliderNavClick($(this));
});
$(window).bind('djaxLoad', function() {
  $('body').off('.nav').on('click.nav', '.SliderNav', function() {
  sliderNavClick($(this));
  });
});

/***** Editing functionality *****/
function beginUpload(hideButton) {
  $('#imgUploadSpinner').addClass('Spinner');
  $('#imgUploadSpinner').css('display', 'inline-block');
  if (hideButton)
  $('#selectImageButton').css('display', 'none');
  $('.UploadImageForm').css('display', 'none');
}
function finishUpload() {
  $('#imgUploadSpinner').removeClass('Spinner');
  $('#imgUploadSpinner').css('display', 'none');
}

function beginProfilePictureUpload() {
  $('#profileUploadSpinner').addClass('Spinner');
  $('#profileUploadSpinner').css('display', 'inline-block');
  $('#profileDarken').css('display', 'block');
}
function finishProfilePictureUpload() {
  $('#profileUploadSpinner').removeClass('Spinner');
  $('#profileUploadSpinner').css('display', 'none');
  $('#profileDarken').css('display', 'none');
}
$('body').on('click', '.ProfilePictureEdit', function() {
  // $('.ProfilePictureEdit').click(function() {
  $('#selectProfile').click();
});
$('body').on('change', '#selectProfile', function() {
  // $('#selectProfile').change(function() {
  console.log('files changed');
  $('#uploadProfileForm').submit();
});
$('body').on('submit', '#uploadProfileForm', function() {
  // $('#uploadProfileForm').submit(function() {
  console.log('profile form submit');
  beginProfilePictureUpload();
});
var img_id = -1;
function profile_target_loaded() {
  console.log('profile target loaded');
  finishProfilePictureUpload();
  var resp = JSON.parse(document.getElementById('profile_target').contentWindow.document.body.textContent);
  /* img_id = parseInt(resp['extra_data'], 10);
   var i = "<img class='ImagePreview' data-media-id='" + img_id + "' src='" + resp['obj_data'] + "' />";
   $('#imageUploadPreview').append(i); */
  $('.ArtistProfilePic').attr('src', resp['obj_data']);
}
$('#profile_target').load(function() {
  profile_target_loaded();
});
$(window).bind('djaxLoad', function() {
  $('#profile_target').load(function() {
  profile_target_loaded();
  });
});

$('body').on('click', '.AddElementFace', function() {
  // $('.AddElementFace').click(function() {
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
var shouldDeleteImage = true;
$('body').on('click', '.AddElementCancel', function() {
  // $('.AddElementCancel').click(function() {
  var info = $(this).closest('.AddElementInfo');
  var face = $(info).siblings('.AddElementFace');
  $(face).css('display', 'block');
  $(info).css('display', 'none');
  if ($(this).attr('id') == 'cancelImage') {
  $('#selectImageButton').css('display', 'block');
  $('#uploadImageForm').css('display', 'block');
  if (shouldDeleteImage) {
    var m_id = $('.ImagePreview').attr('data-media-id');
    $.ajax({
    url: '/' + getArtistNameFromURL() + '/update_content',
    type: 'POST',
    data: { location: 'AboutGalleryImageRemove',
      m_id: m_id
      },
    success: function(resp) {
      console.log('Successfully removed gallery image');
    }
    });
  }
  shouldDeleteImage = true;
  $('.ImagePreview').remove();
  $('#addImageCaption').val('');
  }
  else {
  $('#videoURL').css('display', 'inline-block');
  $('.VideoPreview').remove();
  $('.youtube5placeholder').remove(); // Only for YouTube 5 extension
  $('#addVideoCaption').val('');
  }
});
$('body').on('click', '#selectImageButton', function() {
  // $('#selectImageButton').click(function() {
  $('#selectGalleryImage').click();
});
$('body').on('change', '#selectGalleryImage', function() {
  // $('#selectGalleryImage').change(function() {
  console.log('select gallery image');
  // beginUpload();
  $('#uploadImageForm').submit();
});
$('body').on('submit', '#uploadImageForm', function() {
  // $('#uploadImageForm').submit(function() {
  console.log('gallery image upload submit');
  beginUpload(true);
});
var img_id = -1;
function upload_target_loaded() {
  finishUpload();
  var resp = JSON.parse(document.getElementById('upload_target').contentWindow.document.body.textContent);
  img_id = parseInt(resp['extra_data'], 10);
  var i = "<img class='ImagePreview' data-media-id='" + img_id + "' src='" + resp['obj_data'] + "' />";
  $('#imageUploadPreview').append(i);
}
$('#upload_target').load(function() {
  upload_target_loaded();
});
$(window).bind('djaxLoad', function() {
  // http://stackoverflow.com/a/11613013/472768
  $('#upload_target').off('load.upload');
  $('#upload_target').on('load.upload', function() {
  console.log('djax load bound upload target');
  upload_target_loaded();
  });
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
$('body').on('click', '#saveImage', function() {
  // $('#saveImage').click(function() {
  var caption = $('#addImageCaption').val();
  var order = $('.SliderElement').length;
  $.ajax({
  url: '/' + getArtistNameFromURL() + '/update_content',
  type: 'POST',
  data: { location: 'AboutGalleryImage',
    m_id: img_id,
    caption: caption,
    order: order
    },
  success: function(resp) {
    console.log('Successfully added gallery image');
    var img_tag = "<img src='" + resp['obj_data'] + "' />";
    var m_id = resp['extra_data'];
    createGalleryItemWithContent(img_tag, caption, order, m_id);
    window.location.hash = '#' + order;
    shouldDeleteImage = false;
    $('#cancelImage').click();
  }
  });
});
$('body').on('keydown', '.AddVideoURL', function(event) {
  // $('.AddVideoURL').keydown(function(event) {
  if (event.keyCode !== 13)
  return;
  event.preventDefault();
  $(this).blur();
  return false;
});
$('body').on('blur', '.AddVideoURL', function() {
  // $('.AddVideoURL').blur(function(event) {
  var input = $(this);
  var URL = $(this).val();
  console.log('URL input text: ' + URL);
  if (URL.indexOf('youtube.com') >= 0) {
  var iframe = youtubeIframeForURL(URL);
  iframe = iframe.slice(0, 8) + "class='VideoPreview' " + iframe.slice(8);
  console.log('iframe: ' + iframe);
  $(input).css('display', 'none');
  $('#videoUploadPreview').append(iframe);
  }
});
$('body').on('click', '#saveVideo', function() {
  // $('#saveVideo').click(function() {
  var URL = youtubeEmbedForURL($('.AddVideoURL').val());
  var caption = $('#addVideoCaption').val();
  var order = $('.SliderElement').length;
  $.ajax({
  url: '/' + getArtistNameFromURL() + '/update_content',
  type: 'POST',
  data: { location: 'AboutGalleryVideo',
    video_URL: URL,
    caption: caption,
    order: order
    },
  success: function(resp) {
    console.log('Successfully added gallery media');
    // Create gallery item
    m_id = resp["obj_data"];
    createGalleryItemWithContent(youtubeIframeForURL($('.AddVideoURL').val(), 640, 360), caption, order, m_id);
    // Change hash
    window.location.hash = '#' + order;
    // Clear input
    $('#cancelVideo').click();
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

// http://stackoverflow.com/questions/13929766/event-handlers-not-working-after-dom-manipulation
$(document).on('click', '.SliderElementRemove', function() {
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
    var hash = parseInt(window.location.hash.slice(1), 10);
    hash -= 1;
    window.location.hash = '#' + hash;
    // window.location.hash = '#' + window.location.hash.slice(1);
    // galleryToHash();
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
$(document).on('keydown', '.TitleTextEdit', function(event) {
  // $('.TitleTextEdit').keydown(function(event){
  if (event.keyCode !== 13)  // Check for Return key
  return;

  event.preventDefault();
  $(this).blur();
  return false;
});
$(document).on('blur', '.TitleTextEdit', function() {
  // $('.TitleTextEdit').blur(function(event) {
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
$(document).on('keydown', '.ArtistStory', function(event) {
  // $('.ArtistStory').keydown(function(event) {
  if (event.keyCode !== 13)
  return;
  event.preventDefault();
  $(this).blur();
  return false;
});
$(document).on('blur', '.ArtistStory', function() {
  // $('.ArtistStory').blur(function(event) {
  var nTxt = $(this).html();
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
$(document).on('keydown', '.ContactText', function(event) {
  // $('.ContactText').keydown(function(event) {
  if (event.keyCode !== 13)
  return;
  event.preventDefault();
  $(this).blur();
  return false;
});
$(document).on('blur', '.ContactText', function() {
  // $('.ContactText').blur(function(event) {
  var value = $(this).html();
  var field = $(this).attr('id');
  updateContactInfoForArtist(field, value);
});

$('#event_artistname').val(getArtistNameFromURL());
$(window).bind('djaxLoad', function() {
  $('#event_artistname').val(getArtistNameFromURL());
});
$(window).bind('djaxLoad', function() {
  $('.Datepicker').datetimepicker({
  format: 'MM/dd/yyyy HH:mm PP',
  language: 'en',
  pick12HourFormat: true
  });
});
$('.Datepicker').datetimepicker({
  format: 'MM/dd/yyyy HH:mm PP',
  language: 'en',
  pick12HourFormat: true
});

// $('#finishEventButton').click(function() {
$('body').on('click', '#finishEventButton', function() {
  $('#new_event').submit();
});

/***** Songs upload *****/
function showNewSongModal() {
  $('#backdrop').addClass('In');
  $('#uploadSongs').addClass('In');
}
function dismissNewSongModal() {
  $('#backdrop').removeClass('In');
  $('#uploadSongs').removeClass('In');
}
$('body').on('click', '#uploadSongPrompt', function() {
  showNewSongModal();
});
$('body').on('click', '#uploadSongs .ModalDismiss', function() {
  dismissNewSongModal();
  resetSongUpload();
});
$('body').on('click', '#uploadSongsTarget', function() {
  if ($(this).hasClass('NoPointer'))
  return;

  $('#new_songs_input').click();
});
$('body').on('click', '#new_songs_input', function(event) {
  event.stopPropagation();
});
var uploadQ = [];
function fileAdded(file) {
  var l = uploadQ.push(1);
  if (l > 0)  // Files in the upload queue
  $('#commitSongUploadButton').addClass('disabled');

  $('#uploadSongsPrompt').css('display', 'none');
  $('#uploadSongsTarget').css('border', 'none');
  $('#uploadSongsTarget').addClass('NoPointer');

  var pe = file.previewElement;
  var fileName = file.name;
  var re = /^\d+ [^0-9-\s][^.]+/;
  var songName = '';
  var trackNumber = '';
  if (re.test(fileName)) {
  songName = (fileName.match(/[^0-9-\s][^.]+/))[0];
  trackNumber = (fileName.match(/^\d+/))[0];
  }
  re = /^\d+\s?-\s?[^0-9-\s][^.]+/;
  if (re.test(fileName)) {
  songName = (fileName.match(/[^0-9-\s][^.]+/))[0];
  trackNumber = (fileName.match(/^\d+/))[0];
  }
  re = /^\d+\.\s?[^0-9-\s][^.]+/;
  if (re.test(fileName)) {
  songName = (fileName.match(/[^0-9-\s][^.]+/))[0];
  trackNumber = (fileName.match(/^\d+/))[0];
  }
  re = /Track \d+/;
  if (re.test(fileName))
  trackNumber = (fileName.match(/\d+/))[0];
  re = /Track\s?-\s?\d+/;
  if (re.test(fileName))
  trackNumber = (fileName.match(/\d+/))[0];
  re = /Song \d+/;
  if (re.test(fileName))
  trackNumber = (fileName.match(/\d+/))[0];
  re = /Song\s?-\s?\d+/;
  if (re.test(fileName))
  trackNumber = (fileName.match(/\d+/))[0];
  re = /[^0-9-\s][^.]+/;
  if (re.test(fileName))
  songName = (fileName.match(re))[0];
  trackNumber = trackNumber.replace(/^0+/, '');

  var nf = $(pe).find('.song_name');
  $(nf).val($.trim(songName));
  // Leave out track number; otherwise you'll just have a field with a seemingly random number
  // var tnf = $(pe).find('.song_track_number');
  // $(tnf).val($.trim(trackNumber));

  $('#songsComment').css('display', 'block');
}
function fileUploaded(file, resp) {
  var pe = file.previewElement;
  var aidf = $(pe).find('.AudioID');
  $(aidf).val(resp['audio_id']);
  uploadQ.pop();
  if (uploadQ.length === 0)
  $('#commitSongUploadButton').removeClass('disabled');
}
$(window).bind('djaxLoad', function() {
  // TODO: Check for music page URL before proceeding
  $('.dropzone').dropzone({ url: '/audio' });
});
Dropzone.options.newSongForm = {
  init: function() {
  this.on('addedfile', function(file) { fileAdded(file); });
  this.on('success', function(file, resp) { fileUploaded(file, resp); });
  },
  previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-progress\"><span class=\"dz-upload\" data-dz-uploadprogress=\"\"></span></div>\n  <div class=\"SoundmapPreview\">\n  <img data-dz-thumbnail=\"\">\n  <img class=\"SongDefaultImage\" alt=\"Song_default\" hidpi_src=\"/assets/song_default@2x.png\" src=\"/assets/song_default.png\">  </div>\n  <div class=\"dz-details\">\n  <div class=\"dz-filename\"><span data-dz-name=\"\"></span></div>\n  <div class=\"dz-filesize\"><span data-dz-size></span></div>\n  <form accept-charset=\"UTF-8\" action=\"/songs\" class=\"new_song\" method=\"post\">\n  <input class=\"AudioID\" name=\"audio_id\" type=\"hidden\" />    <label for=\"song_name\">Name</label>\n    <input class=\"song_name\" name=\"song[name]\" placeholder=\"Song name\" required=\"required\" size=\"30\" type=\"text\">\n   <br />   <label for=\"song_track_number\">Track number</label>\n    <input class=\"song_track_number\" name=\"song[track_number]\" placeholder=\"Track number\" required=\"required\" size=\"30\" type=\"text\">\n</form>  </div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage=\"\"></span></div>\n</div>"
};

function addSongToMusicGrid(imgPath, imgCaption, songName, songPath) {
  var s = "<div class='GridItem' data-path='" + songPath + "'><img src='" + imgPath + "' alt='" + imgCaption + "' />  <div class='GridItemDetails'><p class='GridItemName'><span class='GridItemIcon'>&#59406;</span>" + songName + "</p></div></div>";
  if ($('#musicGridSongs .GridItem').length == 0)
  $('#musicGridSongs').append(s);
  else
  $(s).insertBefore($('#musicGridSongs .GridItem').first());
}
function resetSongUpload() {
  $('#commitSongUploadButton').addClass('disabled');
  $('#saveSongsSpinner').css('display', 'none');
  $('#saveSongsText').css('display', 'inline');
  $('#songsComment').css('display', 'none');
  $('#uploadSongsPrompt').css('display', 'inline-block');
  $('#uploadSongsTarget').css('border', '4px dashed transparentize(#AAA, 0.5)');
  $('#uploadSongsTarget').removeClass('NoPointer');
  $('.dz-preview').remove();
}
$('body').on('click', '#commitSongUploadButton', function() {
  var btn = $(this);
  $('#saveSongsText').css('display', 'none');
  $('#saveSongsSpinner').css('display', 'inline');
  $('.dz-success').each(function() {
  var f = $(this);
  var n = $(f).find('.song_name').first().val();
  var tn = $(f).find('.song_track_number').first().val();
  var aid = $(f).find('.AudioID').first().val();
  var p = '/' + getArtistNameFromURL() + '/songs';
  $.ajax({
    url: p,
    type: 'POST',
    data: {
    song_name: n,
    song_track_number: tn,
    song_audio_id: aid
    },
    success: function(resp) {
    var sp = '/' + getArtistNameFromURL() + '/songs/' + resp['song_id'];
    addSongToMusicGrid('/assets/soundmap_loading.png', 'Loading Soundmap', resp['song_name'], sp);
    resetSongUpload();
    }
  });
  });
  dismissNewSongModal();
});

// $('body').on('click', '#backdrop', function() {
//   console.log('Backdrop click');
//   $('#backdrop').removeClass('In');
//   $('#uploadSongs').removeClass('In');
//   $('#showMusic').removeClass('In');
// });
$('body').on('click', '.MusicGridGroup', function() {
  $('#backdrop').removeClass('In');
  $('#uploadSongs').removeClass('In');
  $('#showMusic').removeClass('In');
});

/***** Music grid navigation *****/
function showMusicModal(URL, id) {
  var m = $('#showMusic');
  $.get(URL, function(resp) {
  var s = resp.indexOf('<!-- BEGIN_MODAL -->');
  var e = resp.indexOf('<!-- END_MODAL -->');
  $(m).find('.Load').html(resp.slice(s, e).replace(/&#x27;/g,"\'"));
  setupSongDisplay(id);
  });
  $('#backdrop').addClass('In');
  $(m).addClass('In');
}
function dismissMusicModal() {
  $('#showMusic .m-body Load').html('');
  $('#showMusic').removeClass('In');
  $('#backdrop').removeClass('In');
}
$('body').on('click', '.GridItem', function(event) {
    showMusicModal($(this).data('path'), $(this).data('id'));
    $('div.rateit, span.rateit').rateit();
    event.stopPropagation();
});
$('body').on('click', '#showMusic .ModalDismiss', function() {
  dismissMusicModal();
});

/***** Comments *****/

function refresh_comments() {

  all_comments = $("#all_comments");
  type = all_comments.data('type');
  id = all_comments.data('id');
  path = '/comments/by_type_id/' + type + '/' + id;

  $.ajax({
    'url': path,
    'success': function(data) {
      all_comments.html(data);
      // i don't know why this is necessary, but it is
      load_djax();
    }
  });

};

$('body').on('click', '#refresh_comments', function(event) {
  event.preventDefault();
  refresh_comments();
});

$('body').on('click', ".NewCommentForm > .buttons > #submitComment", function() {
  form = $(this).closest('.NewCommentForm').find('#new_comment');
  handle_comment_form(form);
});

function reply_to(a) {
  comment = $(a).closest('.CommentContainer');
  $(a).css('display', 'none');
  // parent_id = comment.attr("data-id");
  r = comment.find('> .CommentReply');
  r.show();
  // submit = r.find('> .Comment-form > .new_comment > #comment_text');
  // text = comment.find('.CommentContent').first()
  // modal = $("#showMusic > .m-body").first();
  // if(modal.length > 0) {
  //   scrolly = modal;
  // } else {
  //   scrolly = $("#artistPageContent");
  // }
  // scrolly.scrollTo(comment, {offsetTop : 100});
  //  r.css("display", "block");
}


// next few lines stolen from:
// http://stackoverflow.com/questions/5004233/jquery-ajax-post-example

// variable to hold request
var request;
// bind to the submit event of our form
$('body').on("submit", ".NewCommentForm", function(event){
  // prevent default posting of form
  event.preventDefault();
  handle_comment_form($(this));
});
$('body').on('submit', '.CommentReplyForm', function(event) {
  event.preventDefault();
  handle_comment_form($(this));
});

function handle_comment_form(form) {

  // abort any pending request
  if (request) {
    request.abort();
  }

  // setup some local variables
  // let's select and cache all the fields
  var inputs = form.find("input, select, button, textarea");
  // serialize the data in the form
  var serializedData = form.serialize();
  console.log('Serialized: ' + serializedData);

  // let's disable the inputs for the duration of the ajax request
  inputs.prop("disabled", true);

  // fire off the request to /form.php
  request = $.ajax({
    url: "/comments",
    type: "post",
    data: serializedData
  });

  // callback handler that will be called on success
  request.done(function (response, textStatus, jqXHR){
    // log a message to the console
    //console.log(jqXHR);
    refresh_comments();
    $('.CommentMediaOption').removeClass('Selected');
  });

  // callback handler that will be called on failure
  request.fail(function (jqXHR, textStatus, errorThrown){
    // log the error to the console
    console.error(
      "The following error occured: "+
      textStatus, errorThrown
    );
  });

  // callback handler that will be called regardless
  // if the request failed or succeeded
  request.always(function () {
    // reenable the inputs
    inputs.prop("disabled", false);
  });

}

$('body').on('keydown', '.CommentReplyField', function(event) {
  if (event.keyCode !== 13)
  return;
  event.preventDefault();
  $(this).closest('.CommentReplyForm').submit();
  return false;
});
