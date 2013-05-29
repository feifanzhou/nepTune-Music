function toggleCreateNewAccount(tag) {
	if (tag === 1) {
		$("#loginForm").attr('action', '/users');
		$("#loginForm").addClass('new_user');
		$(".LoginHidden").each(function() {
			$(this).slideDown(200);
		});
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
		$("#loginButtonMain").val("Log in");
		$("#createAccount").css('display', 'inline-block');
		$("#goLogin").css('display', 'none');
	}
}