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