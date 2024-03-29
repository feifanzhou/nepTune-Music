// Facebook

  window.fbAsyncInit = function() {
    // init the FB JS SDK
    FB.init({
      appId      : '398320236951675',                        // App ID from the app dashboard
      channelUrl : '/channel.html', // Channel file for x-domain comms
      status     : true,                                 // Check Facebook Login status
      xfbml      : true                                  // Look for social plugins on the page
    });

    // Additional initialization code such as adding Event Listeners goes here
     // Here we subscribe to the auth.authResponseChange JavaScript event. This event is fired
  // for any authentication related change, such as login, logout or session refresh. This means that
  // whenever someone who was previously logged out tries to log in again, the correct case below
  // will be handled.
      /* FB.Event.subscribe('auth.authResponseChange', function(response) {
        // Here we specify what we do with the response anytime this event occurs.
        if (response.status === 'connected') {
          // The response object is returned with a status field that lets the app know the current
          // login status of the person. In this case, we're handling the situation where they
          // have logged in to the app.
          testAPI();
        } else if (response.status === 'not_authorized') {
          // In this case, the person is logged into Facebook, but not into the app, so we call
          // FB.login() to prompt them to do so.
          // In real-life usage, you wouldn't want to immediately prompt someone to login
          // like this, for two reasons:
          // (1) JavaScript created popup windows are blocked by most browsers unless they
          // result from direct interaction from people using the app (such as a mouse click)
          // (2) it is a bad experience to be continually prompted to login upon page load.
          FB.login();
        } else {
          // In this case, the person is not logged into Facebook, so we call the login()
          // function to prompt them to do so. Note that at this stage there is no indication
          // of whether they are logged into the app. If they aren't then they'll see the Login
          // dialog right after they log in to Facebook.
          // The same caveats as above apply to the FB.login() call here.
          FB.login();
        }
      }); */
    };

// Load the SDK asynchronously
(function(d, s, id){
   var js, fjs = d.getElementsByTagName(s)[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement(s); js.id = id;
   js.src = "//connect.facebook.net/en_US/all.js";
   fjs.parentNode.insertBefore(js, fjs);
 }(document, 'script', 'facebook-jssdk'));

// Here we run a very simple test of the Graph API after login is successful.
// This testAPI() function is only called in those cases.
/* function testAPI() {
  console.log('Welcome!  Fetching your information.... ');
  FB.api('/me', function(response) {
    console.log('Good to see you, ' + response.name + '.');
  });
} */

function fb_login(){
  FB.login(function(response) {

    if (response.authResponse) {
      console.log('Welcome!  Fetching your information.... ');
      showFBLoginSpinner();
      //console.log(response); // dump complete info
      access_token = response.authResponse.accessToken; //get access token
      user_id = response.authResponse.userID; //get FB UID
      console.log('FBID: ' + user_id);

      FB.api('/me', function(response) {
        user_email = response.email; //get user email
        console.log('First name: ' + response.first_name);
        console.log('Last name: ' + response.last_name);
            console.log('Email: ' + user_email);
        // jQuery AJAX: http://stackoverflow.com/a/7238119/472768
        $.ajax({
          url: "/login/fb_login",
          type: "POST",
          data: {fb_info: {
                   id: user_id,
                   first_name: response.first_name,
                   last_name: response.last_name,
                   email: response.email
                 }},
          success: function(resp){
            if (resp) {
              url = resp['redir_path']
              if (url)
                window.location = url;
              else
                alert('No redir_path passed back');
            }
          }
        });
      });
    } else {
        //user hit cancel button
        console.log('User cancelled login or did not fully authorize.');
        hideFBLoginSpinner();
    }
  }, {
      scope: 'publish_stream,email'
  });
}
(function() {
    var e = document.createElement('script');
    e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
    e.async = true;
    if (document.getElementById('fb-root')) {
        document.getElementById('fb-root').appendChild(e);
    }
}());
