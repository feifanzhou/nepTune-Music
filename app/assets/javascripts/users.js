/* $(function() {
  $("#musicGrid").masonry({
    itemSelector: '.GridItem',
    columnWidth: floor($('#musicGrid').width() * 0.20)
  })
}) */

$('body').on('click', '#addCredits', function() {
  var creditAmount = $('#newCredits').val();
  if (creditAmount.length == 0 || creditAmount == 0)
    return false;
  var creditAmount = parseInt(creditAmount, 10);
  var creditDisplay = '$' + (creditAmount / 100).toFixed(2);

  var token = function(res){
    var $input = $('<input type=hidden name=stripeToken />').val(res.id);
    $('form').append($input).submit();
  };

  StripeCheckout.open({
    key:         'pk_test_iMhOgbsH06IanFKtsyoHW2zW',
    address:     true,
    amount:      creditAmount,
    currency:    'usd',
    name:        'Add credits',
    description: (creditDisplay + ' additional credit'),
    panelLabel:  'Checkout',
    token:       token
  });

  return false;
});

$('body').on('click', '#submitCredits', function(event) {
  var btn = $(this);
  event.preventDefault();

  $(btn).prop('disabled', true);
  var form = $('#creditForm');

  Stripe.createToken(form, stripeResponseHandler);
  return false;
});
function stripeResponseHandler(status, response) {
  if (status != 200) {
    // https://stripe.com/docs/api#errors
    alert("Something went wrong: " + response.error.message + "\nYou weren't charged.");
    $('#submitCredits').prop('disabled', false);
    return false;
  }

  var taken = response.id;
  var chargeAmount = $('#newCredits').val();
  var userID = $('#userID').val();
  $.ajax({
    url: '/charges',
    type: 'POST', 
    data: { token: token, amount: chargeAmount, user_id: userID },
    done: function() {
      $('#credits').html((chargeAmount / 100).toFixed(2);
    }
  });
}