function toggleCreateNewAccount(tag) {
	$("#loginError").slideUp(200);
	if (tag === 1) {
		$("#loginForm").attr('action', '/users');
		$("#loginForm").addClass('new_user');
		$(".LoginHidden").each(function() {
			$(this).slideDown(200);
		});
		$('#login_password').css('margin-bottom', '0px');
		$("#loginButtonMain").val("Create my account");
		$("#createAccount").css('display', 'none');
		$("#goLogin").css('display', 'inline-block');
	}
	else {
		$("#loginForm").attr('action', '/login');
		$("#loginForm").removeClass('new_user');
		$(".LoginHidden").each(function() {
			$(this).slideUp(200);
		});
		$('#login_password').css('margin-bottom', '10px');
		$("#loginButtonMain").val("Log in");
		$("#createAccount").css('display', 'inline-block');
		$("#goLogin").css('display', 'none');
	}
}

$('#isArtist').change(function() {
	if ($(this).is(':checked'))
		$('#artistUsername').slideDown();
	else
		$('#artistUsername').slideUp();
});