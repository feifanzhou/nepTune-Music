function toggleCreateNewAccount(tag) {
    $("#loginError").slideUp(200);
    if (tag === 1) {
        $("#loginForm").attr('action', '/login/create');
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

if ($('#error_explanation').length != 0) {
    toggleCreateNewAccount(1);
}

$('#isArtist').change(function() {
    if ($(this).is(':checked'))
        $('#artistUsername').slideDown();
    else
        $('#artistUsername').slideUp();
});

/*  To address Asana #6120758366453:
        Fix "I'm an artist" checkbox behavior on creating user failure */
if ($('#isArtist').is(':checked'))
    $('#artistUsername').css('display', 'inline-block');
else
    $('#artistUsername').css('display', 'none');
