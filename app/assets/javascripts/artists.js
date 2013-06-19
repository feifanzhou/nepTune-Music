function setSliderOffset(sliderOffset) {
	$('#slider').css('left', (sliderOffset + 'px'));
}

$(function() {
  var firstElement = $('.SliderElement').first();
  var firstElementWidth = firstElement.width();
  var sliderContainerWidth = $('#sliderContainer').width();
  var sliderStartingOffset = (sliderContainerWidth - firstElementWidth) / 2;
  setSliderOffset(sliderStartingOffset);
});

$('.SliderNav').click(function() {
	var objId = $(this).attr('id');
	var currObj;
	var elementsCount = $('.SliderElement').length;
	if (objId == 'sliderNavLeft') {
		if ($(this).hasClass('SliderNavDisabled'))
			return;
		// Else get previous element and adjust position
		var lastObj;
		$('.SliderElement').each(function(index, element) {
			if ($(this).hasClass('SliderElementCurrent')) {
				currObj = $(this);
				return false;
			}
			else
				lastObj = $(this);
		});
		var sliderOffset = ($('#sliderContainer').width() - $(lastObj).width()) / 2 + $(currObj).width() - $(currObj).position().left;
		$(lastObj).addClass('SliderElementCurrent');
		setSliderOffset(sliderOffset);
	}
	else if (objId == 'sliderNavRight') {
		if ($(this).hasClass('SliderNavDisabled'))
			return;
		// Else get previous element and adjust position
		var nextObj;
		$('.SliderElement').each(function(index, element) {
			console.log('this in loop: ' + $(this));
			if ($(this).hasClass('SliderElementCurrent')) {
				currObj = $(this);
				nextObj = $(this).next();
			}
		});
		var offset = ($('#sliderContainer').width() - $(nextObj).width()) / 2 - $(currObj).width() - $(currObj).position().left;
		$(nextObj).addClass('SliderElementCurrent');
		setSliderOffset(offset);
	}
	$(currObj).removeClass('SliderElementCurrent');
	var newCurr = $('.SliderElementCurrent').first();
	// http://stackoverflow.com/a/2389825/472768
	if ($(newCurr)[0] === $('.SliderElement').first()[0])
		$('#sliderNavLeft').addClass('SliderNavDisabled');
	else
		$('#sliderNavLeft').removeClass('SliderNavDisabled');

	if ($(newCurr)[0] === $('.SliderElement').last()[0])
		$('#sliderNavRight').addClass('SliderNavDisabled');
	else
		$('#sliderNavRight').removeClass('SliderNavDisabled');
});