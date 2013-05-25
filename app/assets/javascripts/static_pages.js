/* Place all the behaviors and hooks related to the matching controller here.
   All this logic will automatically be available in application.js. */

$(function() {
  $(document.body).on('appear', '.AppearCard', function(e, $affected) {
    // add class called “appeared” for each appeared element
    $(this).addClass("appeared");
  });
  $('.AppearCard').appear({force_process: true});
});

$(function() {
	$(".TeamGridItem").popover();
});

function getScrollXY() {
    var x = 0, y = 0;
    if( typeof( window.pageYOffset ) == 'number' ) {
        // Netscape
        x = window.pageXOffset;
        y = window.pageYOffset;
    } else if( document.body && ( document.body.scrollLeft || document.body.scrollTop ) ) {
        // DOM
        x = document.body.scrollLeft;
        y = document.body.scrollTop;
    } else if( document.documentElement && ( document.documentElement.scrollLeft || document.documentElement.scrollTop ) ) {
        // IE6 standards compliant mode
        x = document.documentElement.scrollLeft;
        y = document.documentElement.scrollTop;
    }
    return [x, y];
}

function setHeroHeight() {
	var cHeight = window.innerHeight;
	console.log(window.innerHeight);
	var heroHeight = cHeight - 80;
	$("#signup").css('height', (heroHeight + 'px'));
	if (heroHeight < 430)
		heroHeight = 430;
	$("#marketplace").css('margin-top', (heroHeight + 'px'));
	
	// Set margin on footer to reveal signup
	$("footer").css('margin-bottom', (heroHeight - 20 + 'px'));
}

function scrollToTop() {
	$("html, body").animate({ scrollTop: 0}, 400);
}

function scrollToPartnerSignup() {
	// $("#signupChecks").css('display', 'block');
	scrollToTop();
	return false;
}

function onResize() {
	setHeroHeight();
}

var resizeTimer;
$(window).resize(function() {
	clearTimeout(resizeTimer);
	resizeTimer = setTimeout(onResize, 50);
})