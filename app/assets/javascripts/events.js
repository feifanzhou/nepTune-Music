$('.EventStatusTrigger').bind('ajax:success', function() {
	// TODO: Get current user id from item's data attribute
	var uID = 1;
	var liID = '#' + 'attendeeUser' + uID;
	var destListID = '#' + $(this).data('status') + 'List';
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
});

$('#eventName').keydown(function(event) {
	if (event.keyCode !== 13)
    return;
	event.preventDefault();
	$(this).blur();
	return false;
});
$('#eventName').blur(function(event) {
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

$('#location').keydown(function(event) {
	if (event.keyCode !== 13)
		return;
	event.preventDefault();
	$(this).blur();
	return false;
});
$('#location').blur(function(event) {
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