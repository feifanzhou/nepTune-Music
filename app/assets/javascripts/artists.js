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