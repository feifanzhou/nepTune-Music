/*
* jQuery djax
*
* @version v0.122
*
* Copyright 2012, Brian Zeligson
* Released under the MIT license.
* http://www.opensource.org/licenses/mit-license.php
*
* Homepage:
*   http://beezee.github.com/djax.html
*
* Authors:
*   Brian Zeligson
*
* Contributors:
*  Gary Jones @GaryJones
*
* Maintainer:
*   Brian Zeligson github @beezee
*
*/
!function(t){"use strict";t.fn.djax=function(i,e,n){if(!history.pushState)return t(this);var r=this,a=i,o=e&&e.length?e:[],l=n?n:t.fn.replaceWith;window.history.replaceState({url:window.location.href,title:t("title").text()},t("title").text(),window.location.href),r.clearDjaxing=function(){r.djaxing=!1},r.attachClick=function(i,e){var n=t(i),a=!1;return t.each(o,function(t,i){-1!==n.attr("href").indexOf(i)&&(a=!0),-1!==window.location.href.indexOf(i)&&(a=!0)}),a?t(i):(e.preventDefault(),r.djaxing?(setTimeout(r.clearDjaxing,1e3),t(i)):(t(window).trigger("djaxClick",[i]),r.reqUrl=n.attr("href"),r.triggered=!1,r.navigate(n.attr("href"),!0),void 0))},r.navigate=function(i,e){var n=t(a);r.djaxing=!0,t(window).trigger("djaxLoading",[{url:i}]);var o=function(o){if(i!==r.reqUrl)return r.navigate(r.reqUrl,!1),!0;var c=t(o),d=t(c).find(a);e&&window.history.pushState({url:i,title:t(c).filter("title").text()},t(c).filter("title").text(),i),t("title").text(t(c).filter("title").text()),n.each(function(){var i="#"+t(this).attr("id"),e=d.filter(i),n=t(this);t("a",e).filter(function(){return this.hostname===location.hostname}).addClass("dJAX_internal").on("click",function(t){return r.attachClick(this,t)}),e.length?n.html()!==e.html()&&l.call(n,e):n.remove()}),t.each(d,function(){var i,e=t(this),n="#"+t(this).attr("id");t(n).length||(i=t(c).find(n).prev(),i.length?e.insertAfter("#"+i.attr("id")):e.prependTo("#"+e.parent().attr("id"))),t("a",e).filter(function(){return this.hostname===location.hostname}).addClass("dJAX_internal").on("click",function(t){return r.attachClick(this,t)})}),r.triggered||(t(window).trigger("djaxLoad",[{url:i,title:t(c).filter("title").text(),response:o}]),r.triggered=!0,r.djaxing=!1)};t.get(i,function(t){o(t)}).error(function(t){console.log("error",t),o(t.responseText)})},t(this).find("a").filter(function(){return this.hostname===location.hostname}).addClass("dJAX_internal").on("click",function(t){return r.attachClick(this,t)}),t(window).bind("popstate",function(t){r.triggered=!1,t.originalEvent.state&&(r.reqUrl=t.originalEvent.state.url,r.navigate(t.originalEvent.state.url,!1))})}}(jQuery,window);