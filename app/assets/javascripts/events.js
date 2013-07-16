function event_status_trigger_success(trigger) {
  // TODO: Get current user id from item's data attribute
  console.log('event status trigger success');
  var uID = 1;
  var liID = '#' + 'attendeeUser' + uID;
  var destListID = '#' + $(trigger).data('status') + 'List';
  $(liID).animate({
    marginLeft: '-300px'
  }, 400, function() {
    $(liID).slideUp(400, function() {
      $(liID).detach().appendTo(destListID);
    });
    $(liID).slideDown();
    $(liID).animate({
      marginLeft: '0px'
    }, 400);
  });
}
$('.EventStatusTrigger').bind('ajax:success', function() {
  event_status_trigger_success($(this));
});
$(window).bind('djaxLoad', function() {
  $('.EventStatusTrigger').bind('ajax:success', function() {
    event_status_trigger_success($(this));
  });
});

$('body').on('keydown', '#eventName', function() {
// $('#eventName').keydown(function(event) {
  if (event.keyCode !== 13)
    return;
  event.preventDefault();
  $(this).blur();
  return false;
});
$('body').on('blur', '#eventName', function() {
// $('#eventName').blur(function(event) {
  var input = $(this);
  var e_name = $(this).text();
  $.ajax({
    url: '/events/' + getEventIDFromURL(),
    type: 'PUT',
    data: { name: e_name },
    success: function(resp) {
      console.log('Successfully updated event name');
    }
  });
});

$('body').on('keydown', '#location', function() {
// $('#location').keydown(function(event) {
  if (event.keyCode !== 13)
    return;
  event.preventDefault();
  $(this).blur();
  return false;
});
$('body').on('blur', '#location', function() {
// $('#location').blur(function(event) {
  var input = $(this);
  var e_loc = $(this).text();
  $.ajax({
    url: '/events/' + getEventIDFromURL(),
    type: 'PUT',
    data: { location: e_loc },
    success: function(resp) {
      console.log('Successfully updated event location');
    }
  });
});

// TODO: Refactor and remove duplicate code
$('#startPicker').datetimepicker({
  language: 'en',
  pick12HourFormat: true
});
var start_time_string = $('#start_time_text').text();
var dt = start_time_string.split(' ');
var d = (dt[0]).split('/');
var month = d[0];
var day = d[1];
var year = d[2];
var t = (dt[1]).split(':');
var hour = t[0];
var minute = t[1];
if (dt[2] == 'PM')
  hour += 12;
var date = new Date(year, month, day, hour, minute);
var picker = $('#startPicker').data('datetimepicker');
picker.setDate(date);

$('#startPicker').on('changeDate', function(e) {
  console.log('startTime change');
  console.log(e.date.toString());
  var startTime = $('#startTime').val();
  $.ajax({
    url: '/events/' + getEventIDFromURL(),
    type: 'PUT',
    data: { start_at: startTime },
    success: function(resp) {
      console.log('Successfully updated event start');
    }
  });
});

$('#endPicker').datetimepicker({
  language: 'en',
  pick12HourFormat: true
});
var end_time_string = $('#end_time_text').text();
var dt = end_time_string.split(' ');
var d = (dt[0]).split('/');
var month = d[0];
var day = d[1];
var year = d[2];
var t = (dt[1]).split(':');
var hour = t[0];
var minute = t[1];
if (dt[2] == 'PM')
  hour += 12;
var date = new Date(year, month, day, hour, minute);
var picker = $('#endPicker').data('datetimepicker');
picker.setDate(date);

$('#endPicker').on('changeDate', function(e) {
  console.log('endTime change');
  console.log(e.date.toString());
  var startTime = $('#endTime').val();
  $.ajax({
    url: '/events/' + getEventIDFromURL(),
    type: 'PUT',
    data: { end_at: startTime },
    success: function(resp) {
      console.log('Successfully updated event end');
    }
  });
});