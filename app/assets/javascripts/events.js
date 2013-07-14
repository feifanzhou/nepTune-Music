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