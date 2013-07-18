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

function setDefaultPickerTime(start_or_end) {
  var time_string = $('#' + start_or_end + '_time_text').text();
  console.log('time_string: ' + time_string);
  var dt = time_string.split(' ');
  console.log('dt: ' + dt);
  var d = (dt[0]).split('/');
  console.log('d: ' + d);
  var month = parseInt(d[0], 10) - 1;   // Minus one because months start from 0
  console.log('month: ' + month);
  var day = d[1];
  console.log('day: ' + day);
  var year = d[2];
  console.log('year: ' + year);
  var t = (dt[1]).split(':');
  console.log('t: ' + t);
  var hour = parseInt(t[0], 10);
  var minute = t[1];
  console.log('minute: ' + minute);
  if (dt[2] == 'PM')
    hour += 12;
  console.log('hour: ' + hour);
  var date = new Date(year, month, day, hour, minute);
  console.log('date: ' + date);
  var picker = $('#' + start_or_end + 'Picker').data('datetimepicker');
  picker.setLocalDate(date);
}
// TODO: Refactor and remove duplicate code
$('#startPicker').datetimepicker({
  language: 'en',
  pick12HourFormat: true
});
var is_editing_cookie = readCookie('is_editing');
if (is_editing_cookie == '1')
  setDefaultPickerTime('start');

$('#startPicker').on('changeDate', function(e) {
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
if (is_editing_cookie == '1')
  setDefaultPickerTime('end');

$('#endPicker').on('changeDate', function(e) {
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

// TODO: Refactor modal trigger into shared
function triggerInviteModal() {
  $('#backdrop').addClass('In');
  $('#inviteModal').addClass('In');
}
$('body').on('click', '#invitePrompt', function() {
  triggerInviteModal();  
});
$('#invitePrompt').click(function() {
  triggerInviteModal();
});
$('body').on('click', '.ModalDismiss', function() {
  $('#backdrop').removeClass('In');
  $('#inviteModal').removeClass('In');
});

function inviteToggleClicked(toggle) {
  $('.btn-group-label > p').css('display', 'none');
  var t_id = $(toggle).attr('id');
  var l_id = t_id + 'Label';
  $('#' + l_id).css('display', 'block');
}
$('.InviteToggle').click(function() {
  inviteToggleClicked($(this));
});
$('body').on('click', '.InviteToggle', function() {
  inviteToggleClicked($(this));
});