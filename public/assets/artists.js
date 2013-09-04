function filterMusic(e){switch($(".FilterItem").each(function(){$(this).removeClass("SelectedFilter")}),$(".MusicGridGroupHeader").each(function(){$(this).css("display","none")}),$("#noFilterMatches").css("display","none"),e){case 0:$(".MusicGridGroupHeader").each(function(){$(this).css("display","block")}),$("#filterAll").addClass("SelectedFilter"),$("#musicGridAlbums").css("display","block"),$("#musicGridSongs").css("display","block"),$("#noFilterMatches").css("display","none");break;case 1:$("#filterSongs").addClass("SelectedFilter"),$("#musicGridAlbums").css("display","none"),$("#musicGridSongs").css("display","block");break;case 2:$("#filterAlbums").addClass("SelectedFilter"),$("#musicGridAlbums").css("display","block"),$("#musicGridSongs").css("display","none"),$("#noFilterMatches").css("display","none");break;case 3:$("#filterVideos").addClass("SelectedFilter"),$("#musicGridAlbums").css("display","none"),$("#musicGridSongs").css("display","none"),$("#noFilterMatches").css("display","block");break;case 4:$("#filterOthers").addClass("SelectedFilter"),$("#musicGridAlbums").css("display","none"),$("#musicGridSongs").css("display","none"),$("#noFilterMatches").css("display","block");break;default:$("#musicGridAlbums").css("display","none"),$("#musicGridSongs").css("display","none"),$("#noFilterMatches").css("display","block")}}function primeClick(){$(".MediaDisplayLink").click(function(e){e.preventDefault(),$("#musicGridContainer").addClass("MusicGridDetails"),$("#musicGridFilter").addClass("Hidden"),$("#musicDetailsHeader").addClass("Visible"),$("#itemIcon").html($(this).attr("data-icon")),$("#detailsHeaderTitle").html($(this).attr("data-name")),contentScrollTop=$("#artistPageContent").scrollTop();var t=$(this).attr("href");setTimeout(function(){$("#musicDetailsHeader").css("z-index",2),$("#musicDetailsContent").load(t+" #mainPartial",function(){setTimeout(function(){$("#albumTrackListing").addClass("Visible")},300)})},750)})}function returnToMusicGrid(){$("#musicGridContainer").removeClass("MusicGridDetails"),$("#musicGridFilter").removeClass("Hidden"),$("#musicDetailsHeader").css("z-index",-1),$("#musicDetailsHeader").removeClass("Visible"),primeClick(),setTimeout(function(){$("#itemIcon").empty(),$("#detailsHeaderTitle").empty(),$("#musicDetailsContent").empty(),$("#artistPageContent").animate({scrollTop:contentScrollTop})},750)}function capitalizeFirstLetter(e){return e.charAt(0).toLowerCase()+e.slice(1)}function setCalendarDisplayMode(e){$("#eventsCalendar").removeClass(),$("#eventsCalendar").addClass(e);var t="#"+capitalizeFirstLetter(e);$(".InlineViewMode").each(function(){$(this).removeClass("ViewModeSelected")}),console.log(t),$(t).addClass("ViewModeSelected")}function setSliderOffset(e){$("#slider").css("left",e+"px")}function initialPositionAboutGallery(){var e=$("#gallery0").width(),t=$("#sliderContainer").width(),o=(t-e)/2;setSliderOffset(o)}function setGalleryNavStatus(e){console.log("setGalleryNavStatus: "+e),$(e)[0]===$(".SliderElement").first()[0]?$("#sliderNavLeft").addClass("SliderNavDisabled"):$("#sliderNavLeft").removeClass("SliderNavDisabled"),$(e)[0]===$(".SliderElement").last()[0]?$("#sliderNavRight").addClass("SliderNavDisabled"):$("#sliderNavRight").removeClass("SliderNavDisabled")}function galleryToElement(e){var t,o=0;$(".SliderElementCurrent").removeClass("SliderElementCurrent");for(var a=0;e>=a;a++)t=$("#gallery"+a),e>a&&(o+=$(t).width());var i=($("#sliderContainer").width()-$(t).width())/2,n=-1*o+i;setSliderOffset(n),$(t).addClass("SliderElementCurrent"),setGalleryNavStatus(t)}function galleryToHash(){var e=window.location.hash.slice(1);isNaN(e)||0===e.length||galleryToElement(e)}function sliderNavClick(e){if(console.log("slidernav click"),$(e).hasClass("SliderNavDisabled"))return!1;var t=$(e).attr("id");console.log("slider nav id: "+t);var o=window.location.hash.slice(1);return 0===o.length||isNaN(o)?(window.location.hash="#1",!1):(o=parseInt(o,10),"sliderNavLeft"==t?(console.log("Slider nav left"),o-=1):(console.log("Slider nav right"),o+=1),console.log("new hash: "+o),location.hash="#"+o,!1)}function beginUpload(e){$("#imgUploadSpinner").addClass("Spinner"),$("#imgUploadSpinner").css("display","inline-block"),e&&$("#selectImageButton").css("display","none"),$(".UploadImageForm").css("display","none")}function finishUpload(){$("#imgUploadSpinner").removeClass("Spinner"),$("#imgUploadSpinner").css("display","none")}function beginProfilePictureUpload(){$("#profileUploadSpinner").addClass("Spinner"),$("#profileUploadSpinner").css("display","inline-block"),$("#profileDarken").css("display","block")}function finishProfilePictureUpload(){$("#profileUploadSpinner").removeClass("Spinner"),$("#profileUploadSpinner").css("display","none"),$("#profileDarken").css("display","none")}function profile_target_loaded(){console.log("profile target loaded"),finishProfilePictureUpload();var e=JSON.parse(document.getElementById("profile_target").contentWindow.document.body.textContent);$(".ArtistProfilePic").attr("src",e.obj_data)}function upload_target_loaded(){finishUpload();var e=JSON.parse(document.getElementById("upload_target").contentWindow.document.body.textContent);img_id=parseInt(e.extra_data,10);var t="<img class='ImagePreview' data-media-id='"+img_id+"' src='"+e.obj_data+"' />";$("#imageUploadPreview").append(t)}function createGalleryItemWithContent(e,t,o,a){var i="<div class='SliderElement' id='gallery"+o+"'>";i+="<div class='SliderElementRemoveOverlay'>",i+="<span class='Icon SliderElementRemove' id='remove"+o+"'",i+=" data-media-id='"+a+"'>&#59407;</span></div>",i+="<h2 class='SliderTitle'><p class='TitleTextEdit' contenteditable data-media-id='"+a+"'>",i+=""+t+"</p><p class='ClickToEdit'>Click on caption to edit</p></h2>",i+=""+e+"</div>",$("#slider").append(i)}function renumberGalleryElements(){var e=0;$(".SliderElement").each(function(){$(this).attr("id","gallery"+e),e++}),e=0,$(".SliderElementRemove").each(function(){$(this).attr("id","remove"+e),e++})}function updateCaptionForGalleryItem(e,t){$.ajax({url:"/"+getArtistNameFromURL()+"/update_content",type:"POST",data:{location:"AboutGalleryCaption",mediaID:t,newText:e},success:function(){console.log("Successfully changed media caption")}})}function updateStoryForArtist(e){$.ajax({url:"/"+getArtistNameFromURL()+"/update_content",type:"POST",data:{location:"AboutStory",newText:e},success:function(){console.log("Successfully updated artist story")}})}function updateContactInfoForArtist(e,t){$.ajax({url:"/"+getArtistNameFromURL()+"/update_content",type:"POST",data:{location:"AboutContactInfo",field:e,value:t},success:function(){console.log("Successfully updated artist contact info")}})}function showNewAlbumModal(){$("#backdrop").addClass("In"),$("#createAlbum").addClass("In")}function dismissNewAlbumModal(){$("#backdrop").removeClass("In"),$("#createAlbum").removeClass("In")}function waitForAlbumTargetToFinish(){setTimeout(function(){return $("#album_art_target").contents().length>0?(albumTargetDidFinishLoading(),void 0):void 0},250)}function albumTargetDidFinishLoading(){var e=$("#album_art_target").contents().find("body").html(),t=e.indexOf("}");console.log(e.slice(0,t+1));var o=$.parseJSON(e.slice(0,t+1)),a=o[Object.keys(o)[0]];console.log(a),$("#album_image_id").val(a);var i=o[Object.keys(o)[1]];$("#selectCoverPrompt").css("display","none"),$("#album_art_img").attr("src",i),$("#album_art_img").css("display","block")}function showNewSongModal(){$("#backdrop").addClass("In"),$("#uploadSongs").addClass("In")}function dismissNewSongModal(){$("#backdrop").removeClass("In"),$("#uploadSongs").removeClass("In")}function fileAdded(e){var t=uploadQ.push(1);t>0&&$("#commitSongUploadButton").addClass("disabled"),$("#uploadSongsPrompt").css("display","none"),$("#uploadSongsTarget").css("border","none"),$("#uploadSongsTarget").addClass("NoPointer");var o=e.previewElement,a=e.name,i=/^\d+ [^0-9-\s][^.]+/,n="",s="";i.test(a)&&(n=a.match(/[^0-9-\s][^.]+/)[0],s=a.match(/^\d+/)[0]),i=/^\d+\s?-\s?[^0-9-\s][^.]+/,i.test(a)&&(n=a.match(/[^0-9-\s][^.]+/)[0],s=a.match(/^\d+/)[0]),i=/^\d+\.\s?[^0-9-\s][^.]+/,i.test(a)&&(n=a.match(/[^0-9-\s][^.]+/)[0],s=a.match(/^\d+/)[0]),i=/Track \d+/,i.test(a)&&(s=a.match(/\d+/)[0]),i=/Track\s?-\s?\d+/,i.test(a)&&(s=a.match(/\d+/)[0]),i=/Song \d+/,i.test(a)&&(s=a.match(/\d+/)[0]),i=/Song\s?-\s?\d+/,i.test(a)&&(s=a.match(/\d+/)[0]),i=/[^0-9-\s][^.]+/,i.test(a)&&(n=a.match(i)[0]),s=s.replace(/^0+/,"");var l=$(o).find(".song_name");$(l).val($.trim(n)),$("#songsComment").css("display","block")}function fileUploaded(e,t){var o=e.previewElement,a=$(o).find(".AudioID");$(a).val(t.audio_id),uploadQ.pop(),0===uploadQ.length&&$("#commitSongUploadButton").removeClass("disabled")}function addSongToMusicGrid(e,t,o,a){var i="<div class='GridItem' data-path='"+a+"'><img src='"+e+"' alt='"+t+"' />  <div class='GridItemDetails'><p class='GridItemName'><span class='GridItemIcon'>&#59406;</span>"+o+"</p></div></div>";0==$("#musicGridSongs .GridItem").length?$("#musicGridSongs").append(i):$(i).insertBefore($("#musicGridSongs .GridItem").first())}function resetSongUpload(){$("#commitSongUploadButton").addClass("disabled"),$("#saveSongsSpinner").css("display","none"),$("#saveSongsText").css("display","inline"),$("#songsComment").css("display","none"),$("#uploadSongsPrompt").css("display","inline-block"),$("#uploadSongsTarget").css("border","4px dashed transparentize(#AAA, 0.5)"),$("#uploadSongsTarget").removeClass("NoPointer"),$(".dz-preview").remove()}function fillRatings(){setTimeout(function(){$("div.rateit, span.rateit").html(""),$("div.rateit, span.rateit").rateit()},750)}function showMusicModal(e,t){var o=$("#showMusic");$.get(e,function(e){var a=e.indexOf("<!-- BEGIN_MODAL -->"),i=e.indexOf("<!-- END_MODAL -->");$(o).find(".Load").html(e.slice(a,i).replace(/&#x27;/g,"'")),setupSongDisplay(t)}),$("#backdrop").addClass("In"),$(o).addClass("In"),fillRatings()}function dismissMusicModal(){$("#showMusic .m-body Load").html(""),$("#showMusic").removeClass("In"),$("#backdrop").removeClass("In")}function refresh_comments(){all_comments=$("#all_comments"),type=all_comments.data("type"),id=all_comments.data("id"),path="/comments/by_type_id/"+type+"/"+id,$.ajax({url:path,success:function(e){all_comments.html(e),load_djax(),fillRatings()}})}function reply_to(e){comment=$(e).closest(".CommentContainer"),$(e).css("display","none"),r=comment.find("> .CommentReply"),r.show()}function handle_comment_form(e){request&&request.abort();var t=e.find("#rateit-range-2").attr("aria-valuenow");e.find("#comment_rating").val(t);var o=e.find("input, select, button, textarea"),a=e.serialize();console.log("Serialized: "+a),o.prop("disabled",!0),request=$.ajax({url:"/comments",type:"post",data:a}),request.done(function(){refresh_comments(),$(".CommentMediaOption").removeClass("Selected")}),request.fail(function(e,t,o){console.error("The following error occured: "+t,o)}),request.always(function(){o.prop("disabled",!1)})}var elm=$("#artistSidebar");if(elm.length>0){$(elm).scroll(function(){elm.scrollTop()>15?$("#sidebarShadowTop").fadeTo(1,1):$("#sidebarShadowTop").fadeTo(1,0),elm.innerHeight()+elm.scrollTop()>elm.scrollHeight-5?$("#sidebarShadowBottom").fadeTo(1,0):$("#sidebarShadowBottom").fadeTo(1,1)});var left=$("#artistSidebar").position().left;$("#sidebarShadowTop").css("left",left+"px"),$("#sidebarShadowBottom").css("left",left+"px")}$("body").on("click","#editButton",function(){createCookie("is_editing","1"),$("#editButton").attr("id","uneditButton")}),$("body").on("click","#uneditButton",function(){createCookie("is_editing","0"),$("#uneditButton").attr("id","editButton")});var contentScrollTop=0,sm=25,st=210;$("body").on("mouseover",".GridItem",function(){var e=$(this).find(".GridItemName").first();$(e).stop(!0);var t=$(e).width();if(!(st>t)){var o=t-st,a=o*sm;$(e).animate({left:"-"+o+"px"},a)}}),$("body").on("mouseout",".GridItem",function(){var e=$(this).find(".GridItemName").first();$(e).stop(!0);var t=$(e).width();if(!(st>t)){var o=t-st,a=o*sm;$(e).animate({left:"0px"},a)}}),$(function(){$("#detailsHeaderBack").click(returnToMusicGrid())}),$("body").on("click","#newEventButton",function(){$("#backdrop").addClass("In"),$("#newEvent").addClass("In")}),$("body").on("click","#newEvent .ModalDismiss",function(){$("#backdrop").removeClass("In"),$("#newEvent").removeClass("In")}),$(function(){$(".ArtistNavIcon").tooltip()}),$(window).bind("djaxLoad",function(){$(".ArtistNavIcon").tooltip()}),$("body").on("mouseenter","#sliderContainer",function(){$(".SliderTitle").fadeIn(),$(".SliderTitle").css("bottom","0px")}),$("body").on("mouseleave","#sliderContainer",function(){$(".SliderTitle").fadeOut(),$(".SliderTitle").css("bottom","-50px")}),$("body").on("mouseenter",".NoblockTitle",function(){$(this).fadeOut()}),$("body").on("mouseenter",".SliderTitle",function(){$(this).css("background","rgba(0, 0, 0, 0.90)")}),$("body").on("mouseleave",".SliderTitle",function(){$(this).css("background","rgba(0, 0, 0, 0.70)")}),$(function(){initialPositionAboutGallery()}),$(window).bind("djaxLoad",function(){initialPositionAboutGallery()}),$(function(){galleryToHash()}),$(window).bind("djaxLoad",function(){galleryToHash()}),$(window).bind("hashchange",function(){galleryToHash()}),$("body").on("click.nav",".SliderNav",function(){sliderNavClick($(this))}),$(window).bind("djaxLoad",function(){$("body").off(".nav").on("click.nav",".SliderNav",function(){sliderNavClick($(this))})}),$("body").on("click",".ProfilePictureEdit",function(){$("#selectProfile").click()}),$("body").on("change","#selectProfile",function(){console.log("files changed"),$("#uploadProfileForm").submit()}),$("body").on("submit","#uploadProfileForm",function(){console.log("profile form submit"),beginProfilePictureUpload()});var img_id=-1;$("#profile_target").load(function(){profile_target_loaded()}),$(window).bind("djaxLoad",function(){$("#profile_target").load(function(){profile_target_loaded()})}),$("body").on("click",".AddElementFace",function(){var e=$(this);$(".AddElementOption").each(function(){var t=$(this).children(".AddElementFace"),o=$(this).children(".AddElementInfo");$(t)[0]===$(e)[0]?($(t).css("display","none"),$(o).css("display","block")):($(t).css("display","block"),$(o).css("display","none"))})});var shouldDeleteImage=!0;$("body").on("click",".AddElementCancel",function(){var e=$(this).closest(".AddElementInfo"),t=$(e).siblings(".AddElementFace");if($(t).css("display","block"),$(e).css("display","none"),"cancelImage"==$(this).attr("id")){if($("#selectImageButton").css("display","block"),$("#uploadImageForm").css("display","block"),shouldDeleteImage){var o=$(".ImagePreview").attr("data-media-id");$.ajax({url:"/"+getArtistNameFromURL()+"/update_content",type:"POST",data:{location:"AboutGalleryImageRemove",m_id:o},success:function(){console.log("Successfully removed gallery image")}})}shouldDeleteImage=!0,$(".ImagePreview").remove(),$("#addImageCaption").val("")}else $("#videoURL").css("display","inline-block"),$(".VideoPreview").remove(),$(".youtube5placeholder").remove(),$("#addVideoCaption").val("")}),$("body").on("click","#selectImageButton",function(){$("#selectGalleryImage").click()}),$("body").on("change","#selectGalleryImage",function(){console.log("select gallery image"),$("#uploadImageForm").submit()}),$("body").on("submit","#uploadImageForm",function(){console.log("gallery image upload submit"),beginUpload(!0)});var img_id=-1;$("#upload_target").load(function(){upload_target_loaded()}),$(window).bind("djaxLoad",function(){$("#upload_target").off("load.upload"),$("#upload_target").on("load.upload",function(){console.log("djax load bound upload target"),upload_target_loaded()})}),$("body").on("click","#saveImage",function(){var e=$("#addImageCaption").val(),t=$(".SliderElement").length;$.ajax({url:"/"+getArtistNameFromURL()+"/update_content",type:"POST",data:{location:"AboutGalleryImage",m_id:img_id,caption:e,order:t},success:function(o){console.log("Successfully added gallery image");var a="<img src='"+o.obj_data+"' />",i=o.extra_data;createGalleryItemWithContent(a,e,t,i),window.location.hash="#"+t,shouldDeleteImage=!1,$("#cancelImage").click()}})}),$("body").on("keydown",".AddVideoURL",function(e){return 13===e.keyCode?(e.preventDefault(),$(this).blur(),!1):void 0}),$("body").on("blur",".AddVideoURL",function(){var e=$(this),t=$(this).val();if(console.log("URL input text: "+t),t.indexOf("youtube.com")>=0){var o=youtubeIframeForURL(t);o=o.slice(0,8)+"class='VideoPreview' "+o.slice(8),console.log("iframe: "+o),$(e).css("display","none"),$("#videoUploadPreview").append(o)}}),$("body").on("click","#saveVideo",function(){var e=youtubeEmbedForURL($(".AddVideoURL").val()),t=$("#addVideoCaption").val(),o=$(".SliderElement").length;$.ajax({url:"/"+getArtistNameFromURL()+"/update_content",type:"POST",data:{location:"AboutGalleryVideo",video_URL:e,caption:t,order:o},success:function(e){console.log("Successfully added gallery media"),m_id=e.obj_data,createGalleryItemWithContent(youtubeIframeForURL($(".AddVideoURL").val(),640,360),t,o,m_id),window.location.hash="#"+o,$("#cancelVideo").click()}})}),$(document).on("click",".SliderElementRemove",function(){var e=parseInt($(this).attr("data-media-id"),10),t=getArtistNameFromURL(),o=$(this);$.ajax({url:"/"+t+"/remove_media",type:"POST",data:{location:"AboutGallery",media_index:e},success:function(t){if(t){var a=parseInt(t.success,10);1===a&&(e=parseInt($(o).attr("id").slice(6),10),$("#gallery"+e).fadeOut(),setTimeout(function(){$("#gallery"+e).remove(),renumberGalleryElements();var t=parseInt(window.location.hash.slice(1),10);t-=1,window.location.hash="#"+t},400))}}})}),$(document).on("keydown",".TitleTextEdit",function(e){return 13===e.keyCode?(e.preventDefault(),$(this).blur(),!1):void 0}),$(document).on("blur",".TitleTextEdit",function(){var e=parseInt($(this).attr("data-media-id"),10),t=$(this).html();updateCaptionForGalleryItem(t,e)}),$(document).on("keydown",".ArtistStory",function(e){return 13===e.keyCode?(e.preventDefault(),$(this).blur(),!1):void 0}),$(document).on("blur",".ArtistStory",function(){var e=$(this).html();updateStoryForArtist(e)}),$(document).on("keydown",".ContactText",function(e){return 13===e.keyCode?(e.preventDefault(),$(this).blur(),!1):void 0}),$(document).on("blur",".ContactText",function(){var e=$(this).html(),t=$(this).attr("id");updateContactInfoForArtist(t,e)}),$("#event_artistname").val(getArtistNameFromURL()),$(window).bind("djaxLoad",function(){$("#event_artistname").val(getArtistNameFromURL())}),$(window).bind("djaxLoad",function(){$(".Datepicker").datetimepicker({format:"MM/dd/yyyy HH:mm PP",language:"en",pick12HourFormat:!0})}),$(".Datepicker").datetimepicker({format:"MM/dd/yyyy HH:mm PP",language:"en",pick12HourFormat:!0}),$("body").on("click","#finishEventButton",function(){$("#new_event").submit()}),$("body").on("click","#createAlbumPrompt",function(){showNewAlbumModal()}),$("body").on("click","#createAlbum .ModalDismiss",function(){dismissNewAlbumModal()}),$("body").on("click","#newAlbumArt",function(){$("#image_file").click()}),$("body").on("change","#image_file",function(){$("#album_new_art").submit()}),$("body").on("submit","#album_new_art",function(){waitForAlbumTargetToFinish()}),$("body").on("keyup","#album_name",function(){$("#album_name").val().length>0&&$("#album_image_id").val().length>0&&$("#commitAlbumButton").removeClass("disabled")}),$("body").on("click","#commitAlbumButton",function(e){if($(this).hasClass("disabled"))return e.preventDefault(),!1;var t=$("#album_name").val(),o=(new Date).getFullYear(),a=$("#album_image_id").val(),i=getArtistNameFromURL();$.ajax({url:"/albums",type:"POST",dataType:"JSON",data:{album:{name:t,year:o,art_id:a,artist_route:i}},success:function(){alert("Album created successfully. Refresh to see it show up (really sorry about that, we're working on it!")}})}),$("body").on("click","#uploadSongPrompt",function(){showNewSongModal()}),$("body").on("click","#uploadSongs .ModalDismiss",function(){dismissNewSongModal(),resetSongUpload()}),$("body").on("click","#uploadSongsTarget",function(){$(this).hasClass("NoPointer")||$("#new_songs_input").click()}),$("body").on("click","#new_songs_input",function(e){e.stopPropagation()});var uploadQ=[];$(window).bind("djaxLoad",function(){$(".dropzone").dropzone({url:"/audio"})}),Dropzone.options.newSongForm={init:function(){this.on("addedfile",function(e){fileAdded(e)}),this.on("success",function(e,t){fileUploaded(e,t)})},previewTemplate:'<div class="dz-preview dz-file-preview">\n  <div class="dz-progress"><span class="dz-upload" data-dz-uploadprogress=""></span></div>\n  <div class="SoundmapPreview">\n  <img data-dz-thumbnail="">\n  <img class="SongDefaultImage" alt="Song_default" hidpi_src="/assets/song_default@2x.png" src="/assets/song_default.png">  </div>\n  <div class="dz-details">\n  <div class="dz-filename"><span data-dz-name=""></span></div>\n  <div class="dz-filesize"><span data-dz-size></span></div>\n  <form accept-charset="UTF-8" action="/songs" class="new_song" method="post">\n  <input class="AudioID" name="audio_id" type="hidden" />    <label for="song_name">Name</label>\n    <input class="song_name" name="song[name]" placeholder="Song name" required="required" size="30" type="text">\n   <br />   <label for="song_track_number">Track number</label>\n    <input class="song_track_number" name="song[track_number]" placeholder="Track number" required="required" size="30" type="text">\n</form>  </div>\n  <div class="dz-error-message"><span data-dz-errormessage=""></span></div>\n</div>'},$("body").on("click","#commitSongUploadButton",function(){$(this),$("#saveSongsText").css("display","none"),$("#saveSongsSpinner").css("display","inline"),$(".dz-success").each(function(){var e=$(this),t=$(e).find(".song_name").first().val(),o=$(e).find(".song_track_number").first().val(),a=$(e).find(".AudioID").first().val(),i="/"+getArtistNameFromURL()+"/songs";$.ajax({url:i,type:"POST",data:{song_name:t,song_track_number:o,song_audio_id:a},success:function(e){var t="/"+getArtistNameFromURL()+"/songs/"+e.song_id;addSongToMusicGrid("/assets/soundmap_loading.png","Loading Soundmap",e.song_name,t),resetSongUpload()}})}),dismissNewSongModal()}),$("body").on("click",".MusicGridGroup",function(){$("#backdrop").removeClass("In"),$("#uploadSongs").removeClass("In"),$("#showMusic").removeClass("In")}),fillRatings(),$("body").on("click",".GridItem",function(e){showMusicModal($(this).data("path"),$(this).data("id")),e.stopPropagation()}),$("body").on("click","#showMusic .ModalDismiss",function(){dismissMusicModal()}),$("body").on("click","#refresh_comments",function(e){e.preventDefault(),refresh_comments()}),$("body").on("click",".NewCommentForm > .buttons > #submitComment",function(){form=$(this).closest(".NewCommentForm").find("#new_comment"),handle_comment_form(form)});var request;$("body").on("submit",".NewCommentForm",function(e){e.preventDefault(),handle_comment_form($(this))}),$("body").on("submit",".CommentReplyForm",function(e){e.preventDefault(),handle_comment_form($(this))}),$("body").on("keydown",".CommentReplyField",function(e){return 13===e.keyCode?(e.preventDefault(),$(this).closest(".CommentReplyForm").submit(),!1):void 0}),$("body").on("click",".CommentUpvoteArrow",function(){var e=$(this),t=parseInt($(e).data("upvotes"),10)+1,o=$(e).data("id"),a="/comments/"+o;$.ajax({url:a,type:"PUT",data:{upvotes:t},datatype:"JSON",success:function(o){console.log("increment upvotes works"),o.changed&&$(e).prev().html(""+t),$(e).hasClass("CommentUpvotedArrow")||$(e).addClass("CommentUpvotedArrow")}})});