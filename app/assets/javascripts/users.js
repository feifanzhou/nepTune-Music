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

$('body').on('submit', '#new_charge', function() {
  var btn = $('#submitCredits');

  $(btn).prop('disabled', true);
  var form = $('#new_charge');

  Stripe.createToken(form, stripeResponseHandler);
  return false;
});
function stripeResponseHandler(status, response) {
  alert('stripe response handler');
  if (status != 200) {
    // https://stripe.com/docs/api#errors
    alert("Something went wrong: " + response.error.message + "\nYou weren't charged.");
    $('#submitCredits').prop('disabled', false);
    return false;
  }

  var token = response.id;
  $('#stripeToken').val(token);
  var chargeAmount = $('#newCredits').val();
  var userID = $('#userID').val();
  var formData = $('#new_charge').serialize();
  $.ajax({
    url: '/charges',
    type: 'POST',
    dataType: 'JSON',
    data: formData,
    complete: function(jqXHR, textStatus) {
      var currAmount = parseInt($('#credits').text(), 10);
      var newAmount = parseInt(chargeAmount, 10);
      var totalAmount = currAmount + newAmount;
      // $('#credits').html((totalAmount / 100).toFixed(2));
      $('#credits').html(totalAmount);
    }
  });
  $('#submitCredits').prop('disabled', false); 
}