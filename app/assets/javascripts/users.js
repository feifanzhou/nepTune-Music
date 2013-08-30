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
  $(btn).css('display', 'none');
  $('#submitCreditsSpinner').css('display', 'inline-block');
  var form = $('#new_charge');

  Stripe.createToken(form, stripeResponseHandler);
  return false;
});
function stripeResponseHandler(status, response) {
  if (status != 200) {
    // https://stripe.com/docs/api#errors
    alert("Something went wrong: " + response.error.message + "\nYou weren't charged.");
    resetAddCredits(false);
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
    success: function(data) {
      dismissAddCreditsModal();
      var totalAmount = data.credits;
      $('#credits').html('$' + (totalAmount / 100).toFixed(2));
      $('#credits').data('credits', totalAmount);
      $('#credits').addClass('Highlight');
      setTimeout(function() { $('#credits').removeClass('Highlight') }, 250);
    },
    complete: function() { resetAddCredits(true) }
  });
}

function resetAddCredits(shouldClear) {
  $('#submitCredits').prop('disabled', false);
  $('#submitCredits').css('display', 'inline-block');
  $('#submitCreditsSpinner').css('display', 'none');
  if (shouldClear)
    $('#new_charge').find('input[type=text]').val('');
}
function dismissAddCreditsModal() {
  $('#backdrop').removeClass('In');
  $('#addCredit').removeClass('In');
  resetAddCredits(true);
}
$('body').on('click', '#addCreditButton', function() {
  $('#backdrop').addClass('In');
  $('#addCredit').addClass('In');
});
$('body').on('click', '#addCredit .ModalDismiss', dismissAddCreditsModal);

// Keycodes: http://www.cambiaresearch.com/articles/15/javascript-char-codes-key-codes
function keyCode(event) {
  // http://stackoverflow.com/a/302161/472768
  return (event.keyCode ? event.keyCode : event.which);
}
function isNumberKey(keyCode) {
  return ((keyCode >= 48 && keyCode <= 57) || keyCode == 8 || keyCode == 13 || (keyCode >= 37 && keyCode <= 40));
}
// $('body').on('keyup', '#cardNumber', function(event) {
//   if ($(this).val().length == 4 || ($(this).val().length + 1) % 5 == 0)
//     $(this).val($(this).val() + ' ');
// });
$('body').on('keydown', '#cardExpM', function(event) {
  var kc = keyCode(event);
  if (!isNumberKey(kc)) {
    event.preventDefault();
    return false;
  }
})
$('body').on('keyup', '#cardExpM', function() {
  if ($(this).val().length >= 2)
    $('#cardExpY').focus();
});
$('body').on('keydown', '#cardExpY', function(event) {
  // if ($(this).val().length >= 4) {
  //   event.preventDefault();
  //   return false;
  // }
  var kc = keyCode(event);
  if (!isNumberKey(kc)) {
    event.preventDefault();
    return false;
  }
});