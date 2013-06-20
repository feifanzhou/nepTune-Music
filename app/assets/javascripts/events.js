$('.EventStatusTrigger').bind('ajax:success', function() {
	// TODO: Get current user id from item's data attribute
	var uID = 1;
	var liID = '#' + 'attendeeUser' + uID;
	var destListID = '#' + $(this).data('status') + 'List';
	$(liID).detach().appendTo(destListID);
});