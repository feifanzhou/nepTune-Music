function getScrollXY(){var o=0,e=0;return"number"==typeof window.pageYOffset?(o=window.pageXOffset,e=window.pageYOffset):document.body&&(document.body.scrollLeft||document.body.scrollTop)?(o=document.body.scrollLeft,e=document.body.scrollTop):document.documentElement&&(document.documentElement.scrollLeft||document.documentElement.scrollTop)&&(o=document.documentElement.scrollLeft,e=document.documentElement.scrollTop),[o,e]}function setHeroHeight(){if(!window.mobilecheck){var o=window.innerHeight,e=o-80;$("#signup").css("height",e+"px"),600>e&&(e=600),$("#marketplace").css("margin-top",e+"px"),$("#homeFooter").css("margin-bottom",e-20+"px")}}function scrollToTop(){$("html, body").animate({scrollTop:0},400)}function scrollToPartnerSignup(){return scrollToTop(),!1}function scrollToHomeContent(){var o=.8*window.innerHeight;$("body, html").animate({scrollTop:o})}function onResize(){setHeroHeight()}window.mobilecheck=navigator.userAgent.match(/(iPhone|iPod|Android|BlackBerry)/),$(function(){$("input, textarea").placeholder()}),$(function(){$(".TeamGridItem").tooltip(),$("#artistCheck").tooltip()}),$(window).scroll(function(){window.mobilecheck||($(window).scrollTop()>$(document).height()/2?($("#scrollTop").animate({rotate:"180deg"},0),$("#scrollBottom").css("display","block"),$("#scrollTop").css("display","none")):($("#scrollBottom").animate({rotate:"-180deg"},0),$("#scrollBottom").css("display","none"),$("#scrollTop").css("display","block")))}),$(window).load(function(){setHeroHeight()});var resizeTimer;$(window).resize(function(){clearTimeout(resizeTimer),resizeTimer=setTimeout(onResize,50)}),window.mobilecheck||Modernizr.csstransitions&&Modernizr.csstransitions&&Modernizr.csstransforms3d||($(".AppearCard").each(function(){$(this).addClass("appeared")}),setHeroHeight()),window.mobilecheck||($(document.body).on("appear",".AppearCard",function(){$(this).addClass("appeared")}),$(".AppearCard").appear({force_process:!0}));